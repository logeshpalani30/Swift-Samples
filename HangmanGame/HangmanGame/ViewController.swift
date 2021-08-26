//
//  ViewController.swift
//  HangmanGame
//
//  Created by Logesh Palani on 25/08/21.
//

import UIKit

class ViewController: UIViewController {

    var wordLabel: UILabel!
    var characterField: UITextField!
    var currentWord = "LOGESH"
    var usedLetters = [String]()
    var promptWord = ""{
        didSet{
            wordLabel.text = promptWord
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        wordLabel = UILabel()
        wordLabel.font = UIFont.systemFont(ofSize: 35)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textAlignment = .center
        view.addSubview(wordLabel)
        
        characterField = UITextField()
        characterField.translatesAutoresizingMaskIntoConstraints = false
        characterField.placeholder = "Enter"
        characterField.font = UIFont.systemFont(ofSize: 35)
        characterField.addTarget(self, action: #selector(DoPlayStuff), for: .editingChanged)
        view.addSubview(characterField)
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            wordLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            wordLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            characterField.topAnchor.constraint(equalTo: wordLabel.bottomAnchor,constant: 30),
            characterField.leftAnchor.constraint(equalTo: view.leftAnchor),
            characterField.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setWord()
    }
    
    func setWord(){
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let wordsFile = Bundle.main.url(forResource: "start", withExtension: "txt"){
                if let wordString = try? String(contentsOf: wordsFile){
                    var words = wordString.split(separator: "\n")
                    if !words.isEmpty {
                        words.shuffle()
                        self.currentWord = String(words[0])
                        DispatchQueue.main.async {
                            
                            self.DoPlayStuff()
                        }
                    }
                }
            }
        }
        
    }
    
   @objc func DoPlayStuff() {
        promptWord = ""
    currentWord = currentWord.trimmingCharacters(in: .whitespacesAndNewlines)
    if usedLetters.isEmpty {
        for _ in 0..<currentWord.count/2 {
            usedLetters.append(currentWord.randomElement().map(String.init)!)
        }
    }
        
    
        if self.characterField?.text != nil {
        let guessText = self.characterField?.text
                    if self.currentWord.contains(guessText!){
                        self.usedLetters.append(guessText!)

                    }
            self.characterField?.text = ""
        }
            for letter in self.currentWord {
                let strLetter = String(letter)
                    if self.usedLetters.contains(strLetter) {
                        self.promptWord += strLetter
                    } else {
                        self.promptWord += "?"
                    }
                }
            wordLabel.text = promptWord.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        }
}

