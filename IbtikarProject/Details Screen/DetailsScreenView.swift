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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsScreenPresenter?.loadPaths()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
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
    
    func renderMainCell(indPath: IndexPath , data: Data , path: String) -> Void{
        DispatchQueue.main.async {
            if let mainCell = self.myCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indPath) as? MainCell{
                if let success = self.detailsScreenPresenter?.checkMainImageAndPath(index : indPath , urlPath : path) {
                    if success{
                        mainCell.mainCellImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    func renderSubCell(indPath: IndexPath, data: Data, path: String) -> Void{
        DispatchQueue.main.async {
            if let subCell = self.myCollectionView.cellForItem(at: indPath) as? SubCell{
                if let success = self.detailsScreenPresenter?.checkSubCellAndPath(index : indPath , urlPath : path){
                    if success{
                        subCell.subCellImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailsScreenPresenter?.getCellsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let subCell : SubCell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCell", for: indexPath) as! SubCell
        //        self.uiImageSub = cell.viewWithTag(3) as? UIImageView
        detailsScreenPresenter?.renderSubCellForCellAtIndex(index : indexPath)
        return subCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let mainCell : MainCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "mainCell", for: indexPath) as! MainCell
        mainCell.mainCellLabel.text = detailsScreenPresenter?.getPersonName()
        mainCell.mainCellImage.image = UIImage(named: "avatar")
        detailsScreenPresenter?.renderMainCell(index : indexPath)
        return mainCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showImageView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageVC") as! ShowImageScreenView
        let imageModel = ShowImageScreenModel()
        imageModel.setPath(path: detailsScreenPresenter?.getPathAtIndex(index: indexPath) ?? " ")
        let showImagePresenter = ShowImageScreenPresenter(viewProtocol: showImageView, modelProtocol: imageModel)
        showImageView.setPresenter(presenter: showImagePresenter)
        self.present(showImageView, animated: true, completion: nil)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let imageModel = ShowImageScreenModel()
        imageModel.setPath(path : detailsScreenPresenter?.getPersonPath() ?? " ")
        let imageView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "imageVC") as! ShowImageScreenView
        let showImagePresenter = ShowImageScreenPresenter(viewProtocol: imageView, modelProtocol: imageModel)
        imageView.setPresenter(presenter: showImagePresenter)
        self.present(imageView, animated: true, completion: nil)
    }
}
