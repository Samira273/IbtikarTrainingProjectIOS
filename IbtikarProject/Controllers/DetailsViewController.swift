//
//  DetailsViewController.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/3/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
//    var arrayOfPaths : [String] = []
    var pathsFetchModel = PathsFetchModel()
    var uiImageSub : UIImageView!
    var uiImageMain : UIImageView!
    var uiLableMain : UILabel!
    var per = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getPaths()
        let pathsFetchFinished : (Bool) -> Void = {onSuccess in
            if(onSuccess){
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
            }
            
        }
        pathsFetchModel.getPaths(id: per.id ?? 0, completion: pathsFetchFinished)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
//        self.myCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pathsFetchModel.arrayOfPaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCell", for: indexPath)
        let urlString = "https://image.tmdb.org/t/p/w500/"+pathsFetchModel.arrayOfPaths[indexPath.row]
        getImage(str: urlString , indx: indexPath, type: "subCell")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "mainCell", for: indexPath)
        uiLableMain = cell.viewWithTag(2) as? UILabel
        uiLableMain.text = per.name
        if let temp = per.path{
            let urlString = "https://image.tmdb.org/t/p/w500/"+temp
            getImage(str: urlString, indx: indexPath, type: "mainCell")
        } else{
            ( cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "avatar")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageVC") as! ImageViewController
        imageVC.path = pathsFetchModel.arrayOfPaths[indexPath.row]
        self.present(imageVC, animated: true, completion: nil)
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let imageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageVC") as! ImageViewController
        if(per.path != nil){
            imageVC.path = per.path!
            self.present(imageVC, animated: true, completion: nil)
        }
    }
    

    func getImage(str : String , indx : IndexPath, type : String){
        
        let session = URLSession.shared
        let url = URL(string : str)
        let imageTask = session.dataTask(with: url!, completionHandler: { data, response, error in
            if(data != nil){
                DispatchQueue.main.async {
                    if(type=="subCell"){
                        let currentCell = self.myCollectionView.cellForItem(at: indx)
                        self.uiImageSub = currentCell?.viewWithTag(3) as? UIImageView
                        if ( data != nil && self.uiImageSub != nil){
                            self.uiImageSub.image = UIImage(data: data!)
                            }
                    }  else if(type=="mainCell"){
                        let current = self.myCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indx)
                        self.uiImageMain = current?.viewWithTag(1) as? UIImageView
                        if(data != nil && self.uiImageMain != nil){
                            self.uiImageMain.image = UIImage(data: data!)
                         let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                            if(self.uiImageMain != nil){
                                self.uiImageMain.addGestureRecognizer(tap)
                                self.uiImageMain.isUserInteractionEnabled = true
                            }
                            self.myCollectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader)
                        }
                    }
                }
            }else {
                DispatchQueue.main.async{
                    print("error loading data")
                }
            }
        })
        imageTask.resume()
    }
}
