//
//  PetitionsViewController.swift
//  Whitehouse-Petitions
//
//  Created by Logesh Palani on 20/08/21.
//

import UIKit

class PetitionsViewController: UITableViewController {
    var petitions = [Petition]()
    var orginalList = [Petition]()
    var urlString: String = "https://www.hackingwithswift.com/samples/petitions-1.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if navigationController?.tabBarItem.tag == 1 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        title = "Whitehouse Petitions"
       
        let filter = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showFilter))
        let addCredit = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showUrl))
        navigationItem.rightBarButtonItems = [filter, addCredit]

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    @objc func showFilter() {
        let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Ok", style: .default){
            [weak self, weak ac] _ in
            if let text = ac?.textFields?[0].text{
                self?.filterTableView(text: text)
            }
            
        })
        present(ac, animated: true, completion: nil)
    }
    
    @objc func showUrl() {
        let ac = UIAlertController(title: "Credit", message: "Data coming from white house api \(urlString)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
        
    }
    func filterTableView(text: String) {
        petitions = orginalList.filter {
            petition in
            return petition.title.localizedCaseInsensitiveContains(text)
        }
        if petitions.count == 0 {
            showError(title: "Not found", message:"not found based on search")
        }
        tableView.reloadData()
        
    }
    
    func showError(title: String? = nil, message:String? = nil) {
        let ac = UIAlertController(title: title ?? "Loading Error ", message: message ?? "Something went wrong", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            orginalList = jsonPetitions.results
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.petition = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
