//
//  DetailViewController.swift
//  CountryFlags
//
//  Created by Logesh Palani on 17/08/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selctedImageName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: selctedImageName)
        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }

    @objc func sharedTapped() {
        if let imageData = imageView?.image?.jpegData(compressionQuality: 0.8){
            let vc = UIActivityViewController(activityItems: [imageData, selctedImageName!], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
            present(vc, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
