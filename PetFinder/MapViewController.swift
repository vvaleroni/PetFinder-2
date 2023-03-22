//
//  MapViewController.swift
//  PetFinder
//
//  Created by Va Leroni on 11.03.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

  var pet: Pet!
  @IBOutlet weak var mapView: MKMapView!
  override func viewDidLoad() {
        super.viewDidLoad()

        setupPlacemark()
    }
  @IBAction func close() {
    dismiss(animated: true)
  }
  
  private func setupPlacemark() {
//    guard let location = pet.place else { return }
    let location = "г. Минск, Куйбышева 77"
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
      annotation.title = "MacService" // self.pet.name
      annotation.subtitle = "PetFinder" // self.pet.subtitle
      annotation.coordinate = placemarkLocation.coordinate
      self.mapView.showAnnotations([annotation], animated: true)
      self.mapView.selectAnnotation(annotation, animated: true)
    }
  }
}
