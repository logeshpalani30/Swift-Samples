//
//  NameToFacesController.swift
//  NameToFaces
//
//  Created by Logesh Palani on 26/08/21.
//

import UIKit

class NameToFacesController: UICollectionViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add
                                                                , target: self, action: #selector(addNewPerson))
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentFolderPath().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            do {
                try jpegData.write(to: imagePath)
            } catch {
                fatalError("Can't pick image from gallery")
            }
            
        }
        
        let person = Person(name: "Unknown", imageName: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentFolderPath() -> URL {
        let documentpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentpath[0]
    }
    
    @objc func addNewPerson()  {
        let pc = UIImagePickerController()
        pc.allowsEditing = true
        pc.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            pc.sourceType = .camera
        }
        present(pc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 10
//    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Person", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title:"Cancal", style: .cancel))
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive){[weak self]_ in
            let index = self?.people.firstIndex(of: person)!
            self?.people.remove(at: index!)
            self?.collectionView.reloadData()
        })
        ac.addAction(UIAlertAction(title: "Rename", style: .default){[weak self]_ in
            let rc = UIAlertController(title: "Rename Person", message: nil, preferredStyle: .alert)
            rc.addTextField()
            rc.addAction(UIAlertAction(title: "OK", style: .default){
                [weak self, weak rc]_ in
                guard let text = rc?.textFields?[0].text else {return}
                person.name = text
                self?.collectionView.reloadData()
            })
            self?.present(rc, animated: true)
        })
        present(ac, animated: true)
       
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else { fatalError("unable to dequeue the person cell") }
        let person = people[indexPath.item]
        let imagePath = getDocumentFolderPath().appendingPathComponent(person.imageName)

        cell.imageView.image = UIImage(contentsOfFile:imagePath.path)
        cell.nameLabel.text = person.name

        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.layer.cornerRadius = 7

        return cell
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
