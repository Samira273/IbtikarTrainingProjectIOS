//
//  ProfileViewController.swift
//  IbtikarProject
//
//  Created by Lost Star on 9/3/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var per = Person()
    @IBOutlet weak var myCollectionV: UICollectionView!
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    

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
