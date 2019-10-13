//
//  PathsFetchModel.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/15/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation
import Moya

class DetailsScreenModel : DetailsScreenModelProtocol{
    
    
    var arrayOfPaths : [String] = []
    private var actor : Actor?
    
    func setPersonWith(selectedPerson : Actor) -> Void{
        actor = selectedPerson
    }
    
    func getArraysCount()-> Int{
        return arrayOfPaths.count
    }
    
    func getName() -> String{
        return actor?.name ?? " "
    }
    
    func getPersonPath() -> String{
        return actor?.path ?? " "
    }
    
    func getPathAtIndex(indx: Int) -> String{
        return arrayOfPaths[indx]
    }
    
    func getPaths(completion: @escaping (Bool)-> Void){
        
        let str = "\(actor?.id ?? 0)"
        let provider = MoyaProvider<DetailsTarget>()
        provider.request(.images(id: str)){ result in
            switch result {
            case .success(let response):
                do {
                    //                    let jsonObject = try JSONSerialization.jsonObject(with: response.data)
//                    let jsObj = try JSONSerialization.jsonObject(with: response.data)
                    //                    let dictionary = jsonObject as? NSDictionary
                    //                    let profiles = dictionary?["profiles"] as? [NSDictionary]
                    //                    for profile in profiles!{
                    //                        let path = profile["file_path"] as? String
                    //                        if (path != nil){
                    //                            self.arrayOfPaths.append(path!)
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let codingData = try decoder.decode(Path.CodingData.self, from: response.data)
//                    let path = codingData.pathData
//                    completion(true)
                    
                    let decoder = JSONDecoder()
                  
                    let actorProfiles = try decoder.decode(ActorProfiles.self, from: response.data)
                    print(actorProfiles.id)
                    for profilePath in actorProfiles.profiles{
                        self.arrayOfPaths.append(profilePath.filePath)
                    }
                    completion(true)
             
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            case .failure:
            // 5
            print("network error")
        }
    }
  
}


func getImage(str : String , indx : IndexPath, completion : @escaping (Data, String) -> Void){
    
    let session = URLSession.shared
    let url = URL(string : str)
    let imageTask = session.dataTask(with: url!, completionHandler: { data, response, error in
        if(data != nil){
            completion(data! , str)
        }else {
            DispatchQueue.main.async{
                print("error loading data")
            }
        }
    })
    imageTask.resume()
}
}
