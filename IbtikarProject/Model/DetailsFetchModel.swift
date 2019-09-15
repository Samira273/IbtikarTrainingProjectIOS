//
//  PathsFetchModel.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/15/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation
class DetailsFetchModel{
    var arrayOfPaths : [String] = []
    
    func getPaths(id : Int, completion: @escaping (Bool)-> Void){
        
        let str = "\(id)"
        let url = URL(string : "https://api.themoviedb.org/3/person/"+str + "/images?api_key=6b93b25da5cdb9298216703c40a31832")!
        let session = URLSession.shared
        let pathsTask = session.dataTask(with: url , completionHandler: { data , response, error in
            do{
                if (data != nil ){
                    let jsonObject = try JSONSerialization.jsonObject(with: data!)
                    let dictionary = jsonObject as? NSDictionary
                    let profiles = dictionary?["profiles"] as? [NSDictionary]
                    for profile in profiles!{
                        let path = profile["file_path"] as? String
                        if (path != nil){
                            self.arrayOfPaths.append(path!)
                        }
                    }
                 completion(true)
                }
            }catch {
                print("JSON error: \(error.localizedDescription)")
            }
        })
        pathsTask.resume()
    }
    
    
    func getImage(str : String , indx : IndexPath, completion : @escaping (Data) -> Void){
        
        let session = URLSession.shared
        let url = URL(string : str)
        let imageTask = session.dataTask(with: url!, completionHandler: { data, response, error in
            if(data != nil){
                completion(data!)
            }else {
                DispatchQueue.main.async{
                    print("error loading data")
                }
            }
        })
        imageTask.resume()
    }
}
