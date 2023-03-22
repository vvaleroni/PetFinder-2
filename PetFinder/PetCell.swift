//
//  PetCell.swift
//  Petfinder
//
//  Created by Va Leroni on 15.02.22.
//


import UIKit

class PetCell: UICollectionViewCell {
  static let identifier = "PetCell"
  var pet: Pet?
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var placeLabel: UILabel!
  
  func configure(with pet: Pet) {
    self.pet = pet
    if let photoData = pet.photo, let image = UIImage(data: photoData) {
      imageView.image = image
    } else {
      imageView.image = UIImage(named: "dog1")
    }
    nameLabel.text = pet.name
    placeLabel.text = pet.status
  }
}
