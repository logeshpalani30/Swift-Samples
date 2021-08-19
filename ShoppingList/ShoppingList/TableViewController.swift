//
//  TableViewController.swift
//  ShoppingList
//
//  Created by Logesh Palani on 19/08/21.
//

import UIKit

class TableViewController: UITableViewController {
    var shopingItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptAddDialog))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action
                                          , target: self, action: #selector(promptShareDialog))
        navigationItem.rightBarButtonItems = [addButton, shareButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearItems))
    }
    @objc func clearItems() {
        shopingItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptShareDialog() {
        let ac = UIActivityViewController(activityItems: [shopingItems.joined(separator: "\n")], applicationActivities: [])
        present(ac, animated: true)
    }
    
   @objc func promptAddDialog()  {
        let ac = UIAlertController(title: "Enter Shoping Item Name", message: nil, preferredStyle: .alert)
        ac.addTextField()
    present(ac, animated: true)
    
    let addAction = UIAlertAction(title: "Add", style: .default){
        [weak self, weak ac] action in
        guard let text = ac?.textFields?[0].text! else{return}
        self?.addItem(text)
    }
    
        ac.addAction(addAction)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopingItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shopingItems[indexPath.row]
        return cell;
    }
    
    func addItem(_ item: String){
        shopingItems.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
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
