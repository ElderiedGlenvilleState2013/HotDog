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
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    //var or constants
    let imagePicker = UIImagePickerController()
    var speechSynthesizer = AVSpeechSynthesizer()
    
    
    
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
                    self.navigationItem.title = firstResults.identifier
                    self.synthesizeSpeech(fromString: firstResults.identifier)
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                } else {
                    if let thirdResults = results.first {
                        if thirdResults.identifier.contains("shark") {
                            self.navigationItem.title = thirdResults.identifier
                            self.synthesizeSpeech(fromString: thirdResults.identifier)
                            self.navigationController?.navigationBar.barTintColor = UIColor.green
                            self.navigationController?.navigationBar.isTranslucent = false
                        } else {
                            if let fourthResults = results.first {
                                if fourthResults.identifier.contains("snake") {
                                    self.navigationItem.title = fourthResults.identifier
                                    self.synthesizeSpeech(fromString: fourthResults.identifier)
                                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                                    self.navigationController?.navigationBar.isTranslucent = false
                                } else {
                                    if let fifthResults = results.first {
                                    if fifthResults.identifier.contains("rabbit") {
                                        self.navigationItem.title = fifthResults.identifier
                                        self.synthesizeSpeech(fromString: fifthResults.identifier)
                                        self.navigationController?.navigationBar.barTintColor = UIColor.green
                                        self.navigationController?.navigationBar.isTranslucent = false
                                    } else {
                                        
                                    
                                    self.navigationItem.title = "not sure, Please try again"
                                    self.synthesizeSpeech(fromString: "not sure, Please try again")
                                    self.navigationController?.navigationBar.barTintColor = UIColor.red
                                    self.navigationController?.navigationBar.isTranslucent = false
                                   
                                        }
                                    }
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
    
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText("My food is \(navigationItem.title!)")
            vc?.add(#imageLiteral(resourceName: "hotdogBackground"))
            present(vc!, animated: true, completion: nil)
            
        } else {
            self.navigationItem.title = "Please log in to Twitter"
        }
        
    }
    

    //speechavspeech
    
    func synthesizeSpeech(fromString string: String) {
        let speechUtterance = AVSpeechUtterance(string: string)
        speechSynthesizer.speak(speechUtterance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        speechSynthesizer.delegate = self
        
    }

   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

//extension
extension ViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        //finish utter
    }
}
