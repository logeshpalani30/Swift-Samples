//
//  ViewController.swift
//  WordScramble
//
//  Created by Logesh Palani on 18/08/21.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let contentUrl = Bundle.main.url(forResource: "start", withExtension: ".txt"){
            if let completeString = try? String(contentsOf: contentUrl) {
                allWords = completeString.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["Scamble"]
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptAddDialog))
        startGame()
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
   @objc func promptAddDialog() {
        let ac = UIAlertController.init(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField{ textField in
            textField.placeholder = "Answer"
            textField.textAlignment = .center
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
        [weak self, weak ac] _ in
        guard let answer = ac?.textFields?[0].text else { return }
        self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    func submit(_ answer: String) {
        let title: String
        let message: String
        if isPossible(word: answer) {
            if isOriginal(word: answer) {
                if isReal(word: answer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                } else {
                    title = "Word is not recognized"
                    message = "You can't make them up, you know"
                }
            } else {
                title = "Already exist"
                message = "This word is already added"
            }
        }else{
            title = "Not possible"
            message = "The entered word is not possible"
        }
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {
            return false
        }
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            }else{
               return false
            }
        }
        return true
    }
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelled.location == NSNotFound
    }

}

