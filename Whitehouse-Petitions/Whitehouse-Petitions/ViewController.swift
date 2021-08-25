//
//  ViewController.swift
//  Whitehouse-Petitions
//
//  Created by Logesh Palani on 20/08/21.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        if let url = URL(string: urlString){
            if let jsonPetitions = try? Data(contentsOf: url) {
                Parse(json: jsonPetitions)
            }
        }
    }
    
    func Parse(json: Data) {
        let jsonDecoder = JSONDecoder()
        
        if let decodedPetitions = try? jsonDecoder.decode(Petitions.self, from: json){
            petitions = decodedPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
}

