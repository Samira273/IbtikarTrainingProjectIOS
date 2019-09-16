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
    
    func getPersonName()->String{
        return detailsScreenModel?.getName() ?? " "
    }
    
    func fetchImage(strUrl:String, indPath:IndexPath, typeOfCell:String){
        
        let renderImage : (Data) -> Void = { (innerData) in
            if(typeOfCell=="mainCell"){
                self.detailsScreenView.renderMainCell(indPath : indPath, data: innerData)
            }else if (typeOfCell=="subCell"){
                self.detailsScreenView.renderSubCell(indPath : indPath, data: innerData)
            }
            
        }
        detailsScreenModel?.getImage(str: strUrl, indx: indPath, completion: renderImage)
        
    }
    
    func renderSubCellForCellAtIndex(index : IndexPath){
        var urlString = " "
        if let detailsModel = detailsScreenModel?.getPathAtIndex(indx: index.row){
            urlString = "https://image.tmdb.org/t/p/w500/"+detailsModel
        }
        self.fetchImage(strUrl: urlString, indPath: index, typeOfCell: "subCell")
    }
    
    func renderMainCell(index: IndexPath){
        var urlString = " "
        if let detailsModelMain = detailsScreenModel?.getPersonPath(){
            urlString = "https://image.tmdb.org/t/p/w500/"+detailsModelMain
        }
        self.fetchImage(strUrl: urlString, indPath: index, typeOfCell: "mainCell")
    }
    
}
