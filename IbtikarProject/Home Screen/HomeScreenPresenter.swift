//
//  HomeScreenPresenter.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/16/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation

class HomeScreenPresenter {
    
    private var homeScreenModel : HomeScreenModelProtocol
    private var homeScreenView : HomeScreenViewProtocol
    private var pageNo = 1
    private let apiTotalPages = 500
    private var searchWasDone = false
    private var defaultURL = ""
    private let peopleURL = "https://api.themoviedb.org/3/person/popular?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&page="
    private var searchUrl = ""
    private var noOfCells = 0
    
    init(viewProtocol : HomeScreenViewProtocol , modelProtocol : HomeScreenModelProtocol) {
        
        self.homeScreenView = viewProtocol
        self.homeScreenModel = modelProtocol
    }
    
    func bringAndRender(caller : String){
        var urlString = defaultURL
        if (caller == "search" || searchWasDone){
            urlString = searchUrl
        }
        let page = pageNo
        let renderData: (Bool) -> Void = { onSuccess in
            if(onSuccess){
                 self.noOfCells = self.homeScreenModel.getArraysCount()
                DispatchQueue.main.async {
                    self.homeScreenView.reloadHomeScreen()
                }
            }
        }
        
        homeScreenModel.loadDataOf(url: urlString, forPageNO: page, completion: renderData)
    }
    
    func searchCancel()->Void{
        pageNo = 1
        homeScreenModel.clearData()
        bringAndRender(caller: "search cancel")
    }
    
    func search(keyWord: String?)-> Void{
        searchWasDone = true
        searchUrl = "https://api.themoviedb.org/3/search/person?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&query=\(keyWord?.replacingOccurrences(of: " ", with: "%20") ?? "")&include_adult=false&page="
        bringAndRender(caller: "search")
    }
    
    func settingDefaultUrl(){
        self.defaultURL = self.peopleURL
    }
    
    func settingPageNo(page : Int) ->Void{
        self.pageNo = page
    }
    
    func addPageNo(){
        self.pageNo+=1
    }
    
    func getPageNo()->Int{
        return pageNo
    }
    
    func getNumberOfCells()->Int{
        return noOfCells
    }
    
    func getArrayCount() -> Int{
        return homeScreenModel.getArraysCount()
    }
    
    func getApiTotalPages() -> Int{
        return apiTotalPages
    }
    
    func loadMoreData(){
        pageNo+=1
        homeScreenView.setActivity(status: false)
        homeScreenView.activityAction(action: "start")
        if pageNo <= apiTotalPages{
            bringAndRender(caller: "loadMore")
        }
    }
    
    func checkToLoadMore(index: Int)-> Void{
        if (index == self.getArrayCount() - 1 && self.getPageNo() <= self.getApiTotalPages()){
            self.loadMoreData()
        }
    }
    
    
    func getCellLabelAtIndex(index : Int)->String{
        return homeScreenModel.getPersonAtIndex(index: index).name ?? "No Name Found"
    }
    
    func getCellImageAtIndex(index : Int , completion : @escaping (Data, String) -> Void){
        var url = ""
       
        let setDatataImage : (Data , String) -> Void = { (data , url) in
            completion(data, url)
        }
        if let path = homeScreenModel.getPersonAtIndex(index: index).path{
            url = "https://image.tmdb.org/t/p/w500/"+path
            
            homeScreenModel.imageFromUrl(urlString: url, completion: setDatataImage)
            
        }

    }
}
