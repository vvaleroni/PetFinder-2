//
//  MainViewController.swift
//  Petfinder
//
//  Created by Va Leroni on 18.02.22.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
  var anonimous = true
  var pets = [Pet]()
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  let itemsPerRow = 2.0
  let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var findButton: UIButton!
  @IBOutlet weak var lostButton: UIButton!
  
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let layout = UICollectionViewFlowLayout()
    collectionView.collectionViewLayout = layout
    collectionView.delegate = self
    collectionView.dataSource = self
    findButton.isSelected = false
    lostButton.isSelected = false
    loadPets()
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "petDetailSegue" {
      let controller = segue.destination as! PetViewController
      let cell = sender as! PetCell
      controller.pet = cell.pet
    }
  }
  @IBAction func filtrAction(_ sender: UIButton) {
    sender.isSelected.toggle()
    if sender.isSelected {
      var text: String
      if sender.tag == 0 {
        lostButton.isSelected = false
        text = "Найден"
      } else {
        findButton.isSelected = false
        text = "Потерян"
      }
      let request: NSFetchRequest<Pet> = Pet.fetchRequest()
      request.predicate = NSPredicate(format: "status LIKE %@", text)
      request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      loadPets(with: request)
    } else {
      loadPets()
    }
  }
  
  @IBAction func showMap(_ sender: UIButton) {
    let mapVC = UIStoryboard.main.instantiateViewController(withIdentifier: "MapVC")
    present(mapVC, animated: true, completion: nil)
  }
  @IBAction func addAction(_ sender: UIButton) {
    print("DEBUG: \(#function)")
  }
  @IBAction func unwindSegue(segue: UIStoryboardSegue) {
    if segue.identifier == "saveSegue" {
      findButton.isSelected = false
      lostButton.isSelected = false
      loadPets()
    }
  }

  
  func loadPets(with request: NSFetchRequest<Pet> = Pet.fetchRequest()) {
    do {
      pets = try context.fetch(request)
      collectionView.reloadData()
    } catch {
      print(error.localizedDescription)
    }
  }
}

//extension MainViewController: UICollectionViewDelegate {
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    print(indexPath.item)
//  }
//}

extension MainViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    pets.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCell.identifier, for: indexPath) as! PetCell

    cell.configure(with: pets[indexPath.item])
    return cell
  }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
    let availableWidth = collectionView.frame.width - paddingWidth
    let width = availableWidth / itemsPerRow
    return CGSize(width: width, height: 1.3 * width)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    sectionInserts
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    sectionInserts.left
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    sectionInserts.left
  }
}
