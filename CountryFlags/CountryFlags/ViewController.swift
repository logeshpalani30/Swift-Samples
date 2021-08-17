//
//  ViewController.swift
//  CountryFlags
//
//  Created by Logesh Palani on 17/08/21.
//

import UIKit

class ViewController: UITableViewController {
    var images = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let contents = try! fm.contentsOfDirectory(atPath: path)
        
        for content in contents {
            if content.hasPrefix("flag") {
                images.append(content)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "Coutry Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)
        var imageName = images[indexPath.row]
        let startindex = imageName.startIndex
        let lastIndex = imageName.index(startindex, offsetBy: 5)
        imageName.removeSubrange(startindex...lastIndex)
        cell.textLabel?.text = imageName
        return cell;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
            vc.selctedImageName = images[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

