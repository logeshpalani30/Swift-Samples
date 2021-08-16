//
//  ViewController.swift
//  Project1
//
//  Created by Logesh Palani on 13/08/21.
//

import UIKit

class ViewController: UITableViewController {
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Photos"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                images.append(item)
            }
        }
        print(images)
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = images[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = images[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

