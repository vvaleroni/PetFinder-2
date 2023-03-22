//
//  AddPetTableViewController.swift
//  Petfinder
//
//  Created by Va Leroni on 22.02.22.
//



import UIKit
import CoreData

class AddPetTableViewController: UITableViewController {
  private var image: UIImage?
  private let imagePicker = UIImagePickerController()
  
  @IBOutlet weak var statusSegment: UISegmentedControl!
  @IBOutlet weak var plusPhotoButton: UIButton!
  @IBOutlet weak var petSegment: UISegmentedControl!
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var typeTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var placeTextField: UITextField!
  @IBOutlet weak var mobileTextField: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    updateSaveButtonState()
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    }

  @IBAction func textChanged(_ sender: UITextField) {
    updateSaveButtonState()
  }
  @IBAction func addPhotoButton(_ sender: UIButton) {
    present(imagePicker, animated: true, completion: nil)
  }
  
  private func updateSaveButtonState() {
    saveButton.isEnabled = nameTextField.text != ""
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if segue.identifier == "saveSegue" {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let context = appDelegate.persistentContainer.viewContext
      guard let entity = NSEntityDescription.entity(forEntityName: "Pet", in: context) else { return }
      let pet = Pet(entity: entity, insertInto: context)
      pet.status = statusSegment.selectedSegmentIndex == 0 ? "Потерян" : "Найден"
      pet.name = nameTextField.text ?? ""
      pet.type = typeTextField.text ?? ""
      pet.subtitle = descriptionTextField.text ?? ""
      pet.dog = petSegment.selectedSegmentIndex == 1
      pet.photo = image?.jpegData(compressionQuality: 0.5)
      pet.place = placeTextField.text ?? ""
      pet.mobile = mobileTextField.text ?? ""
      do {
        try context.save()
      } catch let error as NSError {
        print("DEBUG: \(error.localizedDescription)")
      } 
    }
  }
}

extension AddPetTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    self.image = image
    plusPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    dismiss(animated: true, completion: nil)
  }
}
