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
    
    var detailsFetchModel = DetailsFetchModel()
    var uiImageSub : UIImageView!
    var uiImageMain : UIImageView!
    var uiLableMain : UILabel!
    var per = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pathsFetchFinished : (Bool) -> Void = {onSuccess in
            if(onSuccess){
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
            }
        }
        detailsFetchModel.getPaths(id: per.id ?? 0, completion: pathsFetchFinished)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.alwaysBounceVertical = true
        myCollectionView.bounces = true
        myCollectionView.reloadData()
    }
    
    func fetchImage(strUrl:String, indPath:IndexPath, typeOfCell:String){
        
        let renderImage : (Data) -> Void = { (data) in
            if(typeOfCell=="mainCell"){
                DispatchQueue.main.async {
                    let mainCell = self.myCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indPath)
                    mainCell?.viewWithTag(1)
                    self.uiImageMain.image = UIImage(data: data)
                }
                
                
            }else if (typeOfCell=="subCell"){
                DispatchQueue.main.async {
                    
                    let subCell = self.myCollectionView.cellForItem(at: indPath)
                    self.uiImageSub = subCell?.viewWithTag(3)as? UIImageView
                    if((self.uiImageSub) != nil){ self.uiImageSub.image = UIImage(data: data)
                    }
                }
            }
        }
        detailsFetchModel.getImage(str: strUrl, indx: indPath, completion: renderImage)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return detailsFetchModel.arrayOfPaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCell", for: indexPath)
        let urlString = "https://image.tmdb.org/t/p/w500/"+detailsFetchModel.arrayOfPaths[indexPath.row]
        self.uiImageSub = cell.viewWithTag(3) as? UIImageView
        fetchImage(strUrl: urlString, indPath: indexPath, typeOfCell: "subCell")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "mainCell", for: indexPath)
        uiLableMain = cell.viewWithTag(2) as? UILabel
        uiLableMain.text = per.name
        uiImageMain = cell.viewWithTag(1) as? UIImageView
        if let temp = per.path{
            let urlString = "https://image.tmdb.org/t/p/w500/"+temp
            fetchImage(strUrl: urlString, indPath: indexPath, typeOfCell: "mainCell")
        } else{
            ( cell.viewWithTag(1) as! UIImageView).image = UIImage(named: "avatar")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageVC") as! ImageViewController
        imageVC.path = detailsFetchModel.arrayOfPaths[indexPath.row]
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
}
