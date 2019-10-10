//
//  DataFetchModel.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/10/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation
import Alamofire
import Dispatch

class HomeScreenModel : NSObject , HomeScreenModelProtocol{
    

    private var arrayOfActors : [Actor] = []
    var apiTotalPages : Int?
    private let networkDefaults = NetworkDefaults()
    
    func getPersonAtIndex(index: Int) -> Actor {

        return arrayOfActors[index]
    }
    
    func getApiTottalPages() -> Int?{
        return apiTotalPages
    }
    
    func getArraysCount() -> Int{

        return arrayOfActors.count
    }
    
    func loadDataOf(url urlString : String, forPageNO pageNumber : Int, completion: @escaping (Bool)-> Void){
   
        
        if pageNumber == 1{
            arrayOfActors.removeAll()
        }
        Alamofire.request(networkDefaults.baseUrl,
                          method: .get,
                          parameters: ["api_key":networkDefaults.apiKey,
                                       "page": pageNumber],
                          encoding: URLEncoding.default).responseJSON(completionHandler: {response in
                            switch response.result{
                            case .success(_):
                                if let json = response.result.value{
                                    
                                    let apiResponse = ApiResponse(JSON: json as! [String : Any])
                                    self.apiTotalPages = apiResponse?.apiTotalPages
                                    if let actorsResult = apiResponse?.results{
                                        self.arrayOfActors.append(contentsOf: actorsResult)
                                        print(self.arrayOfActors.count)
                                        completion(true)
                                    }
                                   
                                }
                            case .failure(let error):
                                print(error)
                            }
                          })
        

    }
  
    
    func imageFromUrl(urlString: String, completion : @escaping (Data , String)-> Void ) {
        
        let url = URL(string: urlString)
        if(url != nil){
            downloadImageData(from: url!) { data, response, error in
                guard let data = data, error == nil else { return }
                completion(data, urlString)
            }
        }
    }
    
    func downloadImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func clearData()->Void{

        arrayOfActors = []
    }
}

struct NetworkDefaults{
    var baseUrl: String = "https://api.themoviedb.org/3/person/popular"
    var apiKey: String = "1a45f741aada87874aacfbeb73119bae"
    var language : String = "en-US"
}
