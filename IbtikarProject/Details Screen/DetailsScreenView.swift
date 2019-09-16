//
//  DetailsViewController.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/3/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import UIKit

class DetailsScreenView: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , DetailsScreenViewProtocol{
    
    @IBOutlet private weak var myCollectionView: UICollectionView!
    private var detailsScreenPresenter : DetailsScreenPresenter?
    private var uiImageSub : UIImageView!
    private var uiImageMain : UIImageView!
    private var uiLableMain : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsScreenPresenter?.loadPaths()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.alwaysBounceVertical = true
        myCollectionView.bounces = true
        myCollectionView.reloadData()
    }
    
    func setPresenter(presnter : DetailsScreenPresenter)->Void{
        self.detailsScreenPresenter = presnter
    }
    
    func reloadScreen() -> Void{
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
    }
    
    func renderMainCell(indPath: IndexPath , data: Data) -> Void{
        DispatchQueue.main.async {
            let mainCell = self.myCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indPath)
            self.uiImageMain = mainCell?.viewWithTag(1) as? UIImageView
            self.uiImageMain?.image = UIImage(data: data)
        }
    }
    
    func renderSubCell(indPath: IndexPath, data: Data) -> Void{
        DispatchQueue.main.async {
            let subCell = self.myCollectionView.cellForItem(at: indPath)
            self.uiImageSub = subCell?.viewWithTag(3)as? UIImageView
            if((self.uiImageSub) != nil){ self.uiImageSub.image = UIImage(data: data)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailsScreenPresenter?.getCellsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCell", for: indexPath)
        self.uiImageSub = cell.viewWithTag(3) as? UIImageView
        detailsScreenPresenter?.renderSubCellForCellAtIndex(index : indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "mainCell", for: indexPath)
        uiLableMain = cell.viewWithTag(2) as? UILabel
        uiLableMain.text = detailsScreenPresenter?.getPersonName()
        uiImageMain = cell.viewWithTag(1) as? UIImageView
        uiImageMain.image = UIImage(named: "avatar")
        detailsScreenPresenter?.renderMainCell(index : indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageVC") as! ShowImageScreenView
//        imageVC.path = detailsFetchModel.arrayOfPaths[indexPath.row]
        self.present(imageVC, animated: true, completion: nil)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let imageModel = ShowImageScreenModel()
        imageModel.setPath(part : detailsScreenPresenter.getPersonPath())
        let imageView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageVC") as! ShowImageScreenView
//        if(per.path != nil){
//            imageVC.path = per.path!
//            self.present(imageVC, animated: true, completion: nil)
//        }
    }
}
