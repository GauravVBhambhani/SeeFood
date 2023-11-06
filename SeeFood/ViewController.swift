//
//  ViewController.swift
//  SeeFood
//
//  Created by Gaurav Bhambhani on 11/5/23.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var clickedImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera //.photolibrary for accessing photos instead of camera.
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let usersImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            clickedImage.image = usersImage
            
        }
        
        imagePicker.dismiss(animated: true)
        
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }
    
    
    
}

