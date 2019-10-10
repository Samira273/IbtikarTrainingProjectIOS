//
//  Actor.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 10/9/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation
import ObjectMapper

struct ApiResponse : Mappable {
    
    var results : [Actor]?
    var apiTotalPages : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        results <- map["results"]
        apiTotalPages <- map["total_pages"]
    }
    
    
}

struct Actor : Mappable{
    
    var popularity : Double?
    var name : String?
    var path : String?
    var id : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         popularity <- map["popularity"]
         name <- map["name"]
         path <- map["profile_path"]
         id <- map["id"]
    }
    

}
