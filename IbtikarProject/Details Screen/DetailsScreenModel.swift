//
//  PathsFetchModel.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/15/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation
class DetailsScreenModel : DetailsScreenModelProtocol{
    
    
    var arrayOfPaths : [String] = []
    var per = Person()
    
    func setPersonWith(selectedPerson : Person) -> Void{
        per = selectedPerson
    }
    
    func getArraysCount()-> Int{
        return arrayOfPaths.count
    }
    
    func getName() -> String{
        return per.name ?? " "
    }
    
    func getPersonPath() -> String{
        return per.path ?? " "
    }
    
    func getPathAtIndex(indx: Int) -> String{
        return arrayOfPaths[indx]
    }
    
    func getPaths(completion: @escaping (Bool)-> Void){
        
//        let str = "\(per.id ?? 0)"
//        let url = URL(string : "https://api.themoviedb.org/3/person/"+str + "/images?api_key=6b93b25da5cdb9298216703c40a31832")!
//        let session = URLSession.shared
//        let pathsTask = session.dataTask(with: url , completionHandler: { data , response, error in
//            do{
//                if (data != nil ){
//                    let jsonObject = try JSONSerialization.jsonObject(with: data!)
//                    let dictionary = jsonObject as? NSDictionary
//                    let profiles = dictionary?["profiles"] as? [NSDictionary]
//                    for profile in profiles!{
//                        let path = profile["file_path"] as? String
//                        if (path != nil){
//                            self.arrayOfPaths.append(path!)
//                        }
//                    }
//                 completion(true)
//                }
//            }catch {
//                print("JSON error: \(error.localizedDescription)")
//            }
//        })
//        pathsTask.resume()
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
