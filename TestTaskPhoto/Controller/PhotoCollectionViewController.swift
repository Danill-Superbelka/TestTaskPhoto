//
//  PhotoCollectionViewController.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 23.01.2022.
//

import UIKit


class PhotoCollectionViewController: UICollectionViewController {

    private let cache = NSCache<NSNumber, UIImage>()
    private var photosViewModel: PhotoViewModel?
    private var photos:Photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        configTableView()
    }
    
    func configTableView(){
        self.photosViewModel = PhotoViewModel()
        self.photosViewModel!.bindPhotoViewModel = {
            self.photos = self.photosViewModel!.photos
            self.collectionView.reloadData()
        }
    }
    
    private func loadImage(url: URL,completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos:.utility).async {
            let url = url
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
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
            cell.uploadIndicator.isHidden = false
            cell.uploadIndicator.startAnimating()
            let PhotoURL =  URL(string: photos[indexPath.row].url!)
            self.loadImage(url:PhotoURL!) { [weak self] (image) in
                guard let self = self, let image = image else {return}
                cell.photoView.image = image
                self.cache.setObject(image, forKey: itemNumber)
                cell.uploadIndicator.stopAnimating()
                cell.uploadIndicator.isHidden = true
            }
        }
        cell.descriptionPhoto.text = photos[indexPath.row].title
        cell.backgroundColor = .white
        return cell
    }
}
