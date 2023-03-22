//
//  PetViewController.swift
//  Petfinder
//
//  Created by Va Leroni on 17.02.22.
//

import UIKit
import MapKit

class PetViewController: UIViewController {
  var pet: Pet?
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var descriptionLable: UILabel!
  @IBOutlet weak var placeLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPlacemark()
    configure()
  }
  func configure() {
    if let pet = pet {
      if let photoData = pet.photo, let image = UIImage(data: photoData) {
        imageView.image = image
      } else {
        imageView.image = UIImage(named: "dog1")
      }
      statusLabel.text = pet.status
      nameLabel.text = "\(pet.dog ? "Пёс" : "Кот") (\(pet.name ?? ""))"
      placeLabel.text = pet.place
      descriptionLable.text = pet.subtitle
    }
  }
  @IBAction func shareButton(_ sender: UIButton) {
    guard let image = imageView.image else { return }
 
    let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    present(shareController, animated: true, completion: nil)
  }
  
  @IBAction func callButton(_ sender: UIButton) {
    guard let mobile = pet?.mobile, let url = URL(string: "tel://\(mobile)") else { return }
    UIApplication.shared.open(url)
  }
  @IBAction func closeButton(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func deleteButton(_ sender: UIButton) {
    if let pet = pet {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let context = appDelegate.persistentContainer.viewContext
      context.delete(pet)
      do {
        try context.save()
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) else { return }
        guard let controller = window.rootViewController as? MainViewController else { return }
        controller.loadPets()
        dismiss(animated: true, completion: nil)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  private func setupPlacemark() {
    guard let location = pet?.place else { return }

    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      guard let placemarks = placemarks else { return }
      let placemark = placemarks.first
      guard let placemarkLocation = placemark?.location else { return }
      let annotation = MKPointAnnotation()
      annotation.title = self.pet?.name ?? "Пес"
      annotation.subtitle = self.pet?.status
      annotation.coordinate = placemarkLocation.coordinate
      self.mapView.showAnnotations([annotation], animated: true)
      self.mapView.selectAnnotation(annotation, animated: true)
    }
  }
}
