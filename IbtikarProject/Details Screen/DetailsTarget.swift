//
//  DetailsTarget.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 10/9/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation
import Moya

public enum DetailsTarget : TargetType{
    public var baseURL: URL{
        switch self{
        case .images(let id): return URL(string: "https://api.themoviedb.org/3/person/"+id)!
        }
    }
    
    public var path: String{
        switch self {
        case .images: return "/images"
        }
    }
    
    public var method: Moya.Method{
        switch self {
        case .images: return .get
        }
    }
    
    public var sampleData: Data{
        return Data()
    }
    
    public var headers: [String : String]?{
        return ["Content-Type": "application/json"]
    }
    
    public var task: Task {
        let authParams = ["api_key": DetailsTarget.apiKey]
        switch self {
        case .images:
            return .requestParameters(
                parameters: authParams,
                encoding: URLEncoding.default)
        }
    }
    
    static private let apiKey = "6b93b25da5cdb9298216703c40a31832"
    case images(id : String)
}
