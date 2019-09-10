//
//  DataFetchModel.swift
//  IbtikarProject
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation
class DataFetchModel : NSObject {
    var arrayOfPersons : [Person] = []
    var apiTotalPages : Int?
    
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
                            
//                            self.pageNo = dictionary?["page"] as? Int ?? 1
                            for result in results{
                                
                                let person = Person()
                                person.id = result["id"] as? Int
                                person.name = result["name"] as? String
                                person.popularity = result["popularity"] as? Double
                                person.path = result["profile_path"] as? String
                                self.arrayOfPersons.append(person)
                            }
//                            self.pageNo += 1
                            //    self.isDataLoading = false
//                            print ("the global page no is\(self.pageNo-1) totalpages is \(self.apiTotalPages ?? 0)")
                            
                            print("\(self.arrayOfPersons.count)")
                            completion(true)
                            
//                            self.tableView.reloadData()
                            
                        }
                    }
                }
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        })
        
        
        task.resume()
        
    }
}
