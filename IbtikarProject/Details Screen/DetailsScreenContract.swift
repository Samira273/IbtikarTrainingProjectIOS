//
//  DetailsScreenContract.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/16/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation

protocol DetailsScreenModelProtocol {
    
    func getPaths(completion: @escaping (Bool)-> Void)
    func getArraysCount()-> Int
    func getImage(str : String , indx : IndexPath, completion : @escaping (Data , String) -> Void)
    func setPersonWith(selectedPerson : Actor) -> Void
    func getPathAtIndex(indx: Int) -> String
    func getName() -> String
    func getPersonPath() -> String
}

protocol DetailsScreenViewProtocol {
    func reloadScreen() -> Void
    func renderMainCell(indPath: IndexPath, data: Data , path : String) -> Void
    func renderSubCell(indPath: IndexPath, data: Data , path: String) -> Void
}
