//
//  DetailsScreenPresenter.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/16/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation

class DetailsScreenPresenter {
    private var detailsScreenModel : DetailsScreenModelProtocol?
    private var detailsScreenView : DetailsScreenViewProtocol
    
    init(viewProtocol : DetailsScreenViewProtocol , modelProtocol : DetailsScreenModelProtocol) {
        self.detailsScreenView = viewProtocol
        self.detailsScreenModel = modelProtocol
    }
    
    func getCellsCount()->Int?{
        return detailsScreenModel?.getArraysCount()
    }
    
    func loadPaths()->Void{
        let pathsFetchFinished : (Bool) -> Void = {onSuccess in
            if(onSuccess){
                self.detailsScreenView.reloadScreen()
            }
        }
        detailsScreenModel?.getPaths(completion: pathsFetchFinished)
    }
    
    func getPathAtIndex(index : IndexPath) -> String{
        return detailsScreenModel?.getPathAtIndex(indx: index.row) ?? " "
    }
    
    func getPersonName()->String{
        return detailsScreenModel?.getName() ?? " "
    }
    func getPersonPath() -> String{
        return detailsScreenModel?.getPersonPath() ?? " "
    }
    func fetchImage(strUrl:String, indPath:IndexPath, typeOfCell:String , path: String){
        
        let renderImage : (Data , String) -> Void = { (innerData , url) in
            if(typeOfCell=="mainCell"){
                self.detailsScreenView.renderMainCell(indPath : indPath, data: innerData, path: url)
            }else if (typeOfCell=="subCell"){
                self.detailsScreenView.renderSubCell(indPath : indPath, data: innerData, path: url)
            }
            
        }
        detailsScreenModel?.getImage(str: strUrl, indx: indPath, completion: renderImage)
        
    }
    
    func checkMainImageAndPath(index : IndexPath , urlPath : String) -> Bool{
        if let url = detailsScreenModel?.getPersonPath(){
            return urlPath == "https://image.tmdb.org/t/p/w500/"+url
        }
        return false
    }
    
    func checkSubCellAndPath(index : IndexPath , urlPath : String) -> Bool{
        if let url = detailsScreenModel?.getPathAtIndex(indx: index.row){
            return urlPath == "https://image.tmdb.org/t/p/w500/"+url
        }
        return false
    }
    
    func renderSubCellForCellAtIndex(index : IndexPath){
        var urlString = " "
        if let detailsModel = detailsScreenModel?.getPathAtIndex(indx: index.row){
            urlString = "https://image.tmdb.org/t/p/w500/"+detailsModel
             self.fetchImage(strUrl: urlString, indPath: index, typeOfCell: "subCell", path: detailsModel)
        }
       
    }
    
    func renderMainCell(index: IndexPath){
        var urlString = " "
        if let detailsModelMain = detailsScreenModel?.getPersonPath(){
            urlString = "https://image.tmdb.org/t/p/w500/"+detailsModelMain
            self.fetchImage(strUrl: urlString, indPath: index, typeOfCell: "mainCell", path: detailsModelMain)
        }
        
    }
    
}
