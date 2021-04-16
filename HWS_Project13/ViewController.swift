//
//  ViewController.swift
//  HWS_Project13
//
//  Created by J on 2021/04/13.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    
    var currentImage: UIImage!
    
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CoreImageApp"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importImage))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        
    }
    
    @objc func importImage(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
        
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
        
    }
    
    func applyProcessing(){
        
        guard let image = currentFilter.outputImage else { return }
        currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        
        if let cgimg = context.createCGImage(image, from: image.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
        
    }
    
    
    @IBAction func changeFilter(_ sender: Any) {
    }
    
    
    @IBAction func save(_ sender: Any) {
    }
    
    
    
    @IBAction func intensityChange(_ sender: Any) {
    }
    
    
    
}

