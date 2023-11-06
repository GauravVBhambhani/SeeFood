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
            
            guard let ciimage = CIImage(image: usersImage) else {
                fatalError("Could not convert UIImage to CIImage!")
            }
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true)
        
        
        
    }
    
    // Now, after creating ciimage, we create a function that processes the ciimage and returns an interpretation of the image.
    func detect(image: CIImage) {
        
        // VNCoreMLModel comes from Vision
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("CoreML Model did not load!")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image!")
            }
//            print(results)
//            get first item with highest accuracy from result
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog") {
                    self.navigationItem.title = "Hotdog!"
                } else {
                    self.navigationItem.title = "Notdog!"
                }
            }
        }
        
        // create a handler whcih specifies which image we want to classify.
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }
    
    
    
}

