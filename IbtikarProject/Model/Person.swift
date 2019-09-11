//
//  Person.swift
//  IbtikarProject
//
//  Created by Lost Star on 9/2/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation


class Person :NSObject{
    
    var popularity : Double?
    var name : String?
    var path : String?
    var id : Int?
    
     override init() {
        popularity = 0.0
        name = ""
        path = ""
        id = 0
    }
}
