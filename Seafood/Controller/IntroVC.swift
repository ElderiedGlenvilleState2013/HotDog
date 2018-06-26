//
//  IntroVC.swift
//  HotDogZ!
//
//  Created by McKinney family  on 6/25/18.
//  Copyright © 2018 FasTek Technologies. All rights reserved.
//

import UIKit

class IntroVC: UIViewController {

    
    @IBAction func hotdogBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "PicSeqgue", sender: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
