//
//  ViewController.swift
//  Seafood
//
//  Created by McKinney family  on 6/24/18.
//  Copyright © 2018 FasTek Technologies. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Social


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    let imagePicker = UIImagePickerController()
    
    
    
    
    //outlets
    @IBOutlet weak var foodIMG: UIImageView!
    
    
    
    
    //delegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        foodIMG.image = userPickImage
            guard let ciimage = CIImage(image: userPickImage) else {
                fatalError("could not convert UIImage to CIImage")
            }
            detect(image: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
       
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("loading CoreML Model faild")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("model failed to process image.")
                
            }
              print(results)
           
            if let firstResults = results.first {
                if firstResults.identifier.contains("terrier") {
                    self.navigationItem.title = "It's a Dog!"
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                } else {
                    if let thirdResults = results.first {
                        if thirdResults.identifier.contains("hamster") {
                            self.navigationItem.title = "It's a Hamster!"
                            self.navigationController?.navigationBar.barTintColor = UIColor.green
                            self.navigationController?.navigationBar.isTranslucent = false
                        } else {
                            if let fourthResults = results.first {
                                if fourthResults.identifier.contains("rabbit") {
                                    self.navigationItem.title = "it's a rabbit!"
                                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                                    self.navigationController?.navigationBar.isTranslucent = false
                                } else {
                                    self.navigationItem.title = "not an Aninmal"
                                    self.navigationController?.navigationBar.barTintColor = UIColor.red
                                    self.navigationController?.navigationBar.isTranslucent = false
                                }
                            }
                        }
                    }
                   
                }
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
        try! handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    //IBAction button
    @IBAction func cameraPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText("My food is \(navigationItem.title!)")
            vc?.add(#imageLiteral(resourceName: "hotdogBackground"))
            present(vc!, animated: true, completion: nil)
            
        } else {
            self.navigationItem.title = "Please log in to Twitter"
        }
        
    }
    

    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

