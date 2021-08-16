//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Logesh Palani on 16/08/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var countButton = UIBarButtonItem(title: "0", style: .plain, target: .none, action: nil)
    var totalTried = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = countButton
        // Do any additional setup after loading the view.
        countries+=["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1;
        button2.layer.borderWidth = 2;
        button3.layer.borderWidth = 3;
        
        button1.layer.borderColor = UIColor.gray.cgColor
        button2.layer.borderColor = UIColor.gray.cgColor
        button3.layer.borderColor = UIColor.gray.cgColor
        
        askQuestion()
    }

    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<countries.count)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = countries[correctAnswer].uppercased()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
                
        totalTried+=1
        
        var title = ""
        
        if totalTried==10 {
            title = "Game Over"
            let ac = UIAlertController(title:  title, message: "Game over", preferredStyle: .alert)
                       
            ac.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            
            present(ac, animated: true)
            score = 0
            totalTried = 0;
        }
        if title != "Game Over"   {
            if sender.tag == correctAnswer {
                score+=1
            }
            else {
                score-=1
                title = "Wrong Answer"
                let ac = UIAlertController(title:  title, message: "You're wrong", preferredStyle: .alert)
                           
                ac.addAction(UIAlertAction(title: "OK", style: .default,handler: askQuestion(action:)))
                
                present(ac, animated: true)
            }
        }
        
       
        countButton.title = String(score)
    }
}

