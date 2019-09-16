//
//  Contract.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/16/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation

protocol HomeScreenViewProtocol {
    func  reloadHomeScreen() -> Void
    func setActivity(status : Bool) -> Void
    func activityAction(action: String)->Void
}



protocol HomeScreenModelProtocol {
    
     func loadDataOf(url urlString : String, forPageNO pageNumber : Int, completion: @escaping (Bool)-> Void)
    
    func clearData()->Void
    
    func getPersonAtIndex (index : Int) -> Person
    
    func getApiTottalPages() -> Int?
    
    func getArraysCount() -> Int
    
    func imageFromUrl(urlString: String, completion : @escaping (Data , String)-> Void ) 
    
}
