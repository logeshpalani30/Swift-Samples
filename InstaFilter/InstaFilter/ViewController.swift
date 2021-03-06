//
//  ViewController.swift
//  InstaFilter
//
//  Created by Logesh Palani on 31/08/21.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnChangeFilter: UIButton!
    @IBOutlet weak var intensity: UISlider!
    var filters = ["CIBumpDistortion", "CIBumpDistortion", "CIPixellate", "CISepiaTone", "CITwirlDistortion", "CIUnsharpMask", "CIVignette"]
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Insta Filter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importImage))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        
        // Do any additional setup after loading the view.
    }
    @IBAction func intensityChangeed(_ sender: Any) {
        applyProcessing()
    }
    @objc func importImage(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        dismiss(animated: true)
        
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
        
    }
    func applyProcessing() {
        guard let image = currentFilter.outputImage else { return }

        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2 ), forKey: kCIInputCenterKey)
        }
                
        if let cgimg = context.createCGImage(image, from: image.extent){
            let processImage = UIImage(cgImage: cgimg)
            imageView.image = processImage
        }
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        for filter in filters {
            ac.addAction(UIAlertAction(title: filter, style: .default, handler: setFilter))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
       
    }
    func setFilter(action: UIAlertAction) {
     
        guard currentImage != nil else { return }
        guard let actionTitle = action.title else { return }

        currentFilter = CIFilter(name: actionTitle)

        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

        applyProcessing()
    }
    @IBAction func save(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self,#selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
            let ac = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            return
        }
        let ac = UIAlertController(title: "Saved", message: "You alerted image saved", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
}

