//
//  PhotoCollectionViewCell.swift
//  TestTaskPhoto
//
//  Created by Даниил  on 23.01.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var descriptionPhoto: UILabel!
    @IBOutlet var uploadIndicator: UIActivityIndicatorView!

    var cornerRadius: CGFloat = 5.0
    
   override func awakeFromNib() {
        super.awakeFromNib()
       uploadIndicator.isHidden = true
//Тень и закругленные углы
       layer.shadowColor = UIColor.lightGray.cgColor
       layer.shadowOffset = CGSize(width: 0, height: 2.0)
       layer.shadowRadius = 5.0
       layer.shadowOpacity = 1.0
       layer.masksToBounds = false
       layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
       layer.backgroundColor = UIColor.clear.cgColor

       contentView.layer.masksToBounds = true
       layer.cornerRadius = 10

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
}

