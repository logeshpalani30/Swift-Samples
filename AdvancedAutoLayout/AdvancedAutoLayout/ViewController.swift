//
//  ViewController.swift
//  AdvancedAutoLayout
//
//  Created by Logesh Palani on 19/08/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "Label 1"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "Label 2"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .blue
        label3.text = "Label 3"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "Label 4"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .purple
        label5.text = "Label 5"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        let allLabels = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//        for label in allLabels.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: allLabels))
//        }
//        let labelHeights = ["labelHeight":140]
//        // in this vertical constraint only given to close | not bottom, if you set end in | the first view takes the max with by default
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=20)-|", options: [], metrics: labelHeights, views: allLabels))
        
        var previousLabel: UILabel?

        for label in [label1, label2, label3, label4, label5] {
//            label.trailingAnchor.constraint(equalToConstant: 10).isActive = true
//            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: view.bounds.width - label.bounds.width).isActive = true
//            label.leadingAnchor.constraint(lessThanOrEqualTo: ,constant: (view.bounds.width - label.bounds.width)).isActive = true
            label.rightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
//            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            label.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.1, constant: 20).isActive = true
            if let previous = previousLabel {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            }
            else{
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            previousLabel = label
        }
        
    }
}

