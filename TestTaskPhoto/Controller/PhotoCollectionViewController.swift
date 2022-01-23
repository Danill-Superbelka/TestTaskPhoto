//
//  PhotoCollectionViewController.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 23.01.2022.
//

import UIKit


class PhotoCollectionViewController: UICollectionViewController {

    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)

    
    private var photosViewModel: PhotoViewModel?
    var photos:Photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        configTableView()
//        print("Из Коллекции", urlPhoto)
        // Do any additional setup after loading the view.
    }
    func configTableView(){
        self.photosViewModel = PhotoViewModel()
        self.photosViewModel!.bindPhotoViewModel = {
            self.photos = self.photosViewModel!.photos
            self.collectionView.reloadData()
            print(self.photos)
        }
    }
    
    private func loadImage(url: URL,completion: @escaping (UIImage?) -> ()) {
            utilityQueue.async {
                let url = url

                guard let data = try? Data(contentsOf: url) else { return }
                let image = UIImage(data: data)

                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count != 0 ? photos.count:0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! PhotoCollectionViewCell
        let itemNumber = NSNumber(value: indexPath.item)

        if let cachedImage = self.cache.object(forKey: itemNumber) {
            cell.photoView.image = cachedImage
        } else {
            let url =  URL(string: photos[indexPath.row].thumbnailURL!)
            self.loadImage(url:url!) { [weak self] (image) in
                guard let self = self, let image = image else {return}
                cell.photoView.image = image
                self.cache.setObject(image, forKey: itemNumber)
            }
            
        }
//        cell.imageURL = URL(string: photos[indexPath.row].thumbnailURL!)
        cell.descriptionPhoto.text = photos[indexPath.row].title
        return cell
    }
}

class PhotoCollectionViewCell: UICollectionViewCell {
    //static let indetifier = "PhotoCollectionViewCell"
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var descriptionPhoto: UILabel!
    @IBOutlet var uploadIndicator: UIActivityIndicatorView!
    
//    var imageURL: URL? {
//        didSet{
//            photoView?.image = nil
//            updateUI()
//        }
//    }
//
//    private func updateUI() {
//        if let url = imageURL {
//            uploadIndicator?.startAnimating()
//            DispatchQueue.global(qos: .userInitiated).async {
//                let photoFromURL = try? Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    if url == self.imageURL {
//                    if let photoData = photoFromURL {
//                        self.photoView?.image = UIImage(data: photoData)
//                        }
//                    }
//                    self.uploadIndicator?.stopAnimating()
//                }
//            }
//        }
//    }
    
    var cornerRadius: CGFloat = 5.0

    override func awakeFromNib() {
        super.awakeFromNib()

        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true

        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false

        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }

    func configurationCell(item:Int){
        descriptionPhoto?.text = "\(item)"
    }
    
}
