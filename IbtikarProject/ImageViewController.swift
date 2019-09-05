//
//  ImageViewController.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/5/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
   
  
    var path : String = ""
    
    
    @IBAction func goBackToCollection(_ sender: Any) {
    }
    @IBAction func saveImage(_ sender: Any) {
    }
    
    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Do any additional setup after loading the view.
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
