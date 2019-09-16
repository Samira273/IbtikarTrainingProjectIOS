//
//  DataFetchModel.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/10/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation
class HomeScreenModel : NSObject , HomeScreenModelProtocol{
    
    private var arrayOfPersons : [Person] = []
    var apiTotalPages : Int?
    
    func getPersonAtIndex(index: Int) -> Person {
        return arrayOfPersons[index]
    }
    
    func getApiTottalPages() -> Int?{
        return apiTotalPages
    }
    
    func getArraysCount() -> Int{
        return arrayOfPersons.count
    }
    
    func loadDataOf(url urlString : String, forPageNO pageNumber : Int, completion: @escaping (Bool)-> Void){
        
        let session = URLSession.shared
        let url = URL(string: urlString+"\(pageNumber)")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            do {
                if (data != nil ){
                    let jsonObject = try JSONSerialization.jsonObject(with: data!)
                    let dictionary = jsonObject as? NSDictionary
                    DispatchQueue.main.async {
                        if pageNumber==1{
                            self.arrayOfPersons.removeAll()
                        }
                        if let results = dictionary?["results"] as? [NSDictionary]{
                            self.apiTotalPages = dictionary?["total_pages"] as? Int
                            for result in results{
                                let person = Person()
                                person.id = result["id"] as? Int
                                person.name = result["name"] as? String
                                person.popularity = result["popularity"] as? Double
                                person.path = result["profile_path"] as? String
                                self.arrayOfPersons.append(person)
                            }
                            print("\(self.arrayOfPersons.count)")
                            completion(true)
                        }
                    }
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        })
        task.resume()
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
        arrayOfPersons = []
    }
}
