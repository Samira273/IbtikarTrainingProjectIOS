//
//  ActorProfile.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 10/10/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation

struct ActorProfiles : Codable {
    var profiles : [Profile]
    var id : Int
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(Int.self, forKey: .id)
//        profiles = try container.decode([Path].self, forKey: .profiles)
//    }
}

struct Profile : Codable{
    
//    let iso639_1: JSONNull?
//    let width, height, voteCount: Int
//    let voteAverage: Double
    let filePath: String
//    let aspectRatio: Double
    
//    init(from decoder : Decoder) throws{
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        file_Path = try container.decode(String.self, forKey: .file_Path)
//    }
    
    enum CodingKeys: String, CodingKey {
//        case iso639_1 = "iso_639_1"
//        case width, height
//        case voteCount = "vote_count"
//        case voteAverage = "vote_average"
        case filePath = "file_path"
//        case aspectRatio = "aspect_ratio"
    }
    
}

//extension Path{
//    struct CodingData: Codable {
//        struct Container: Codable {
//            var path : String
//        }
//        var pathData: Container
//    }
//}
