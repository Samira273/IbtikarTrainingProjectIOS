//
//  DetailsScreenPresenter.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/16/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation

class DetailsScreenPresenter {
    var detailsScreenModel : DetailsScreenModelProtocol?
    var detailsScreenView : DetailsScreenViewProtocol
    
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
    
    func showImageForCellAtIndex(index : IndexPath){
        let urlString = "https://image.tmdb.org/t/p/w500/"+detailsScreenModel?.getPathAtIndex(indx: index.row) ?? <#default value#> ?? " "
        self.fetchImage(strUrl: urlString, indPath: index, typeOfCell: "subCell")
    }
    
}
