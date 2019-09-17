//
//  ImageFetchModel.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/11/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation

class ShowImageScreenModel : ShowImageScreenModelProtocol{
    
    
    private var baseUrl : String = "https://image.tmdb.org/t/p/w500/"
    private var path : String = ""
    
    func setPath(path : String){
        self.path = path
    }
    
    func imageFromUrl(completion : @escaping (Data)-> Void ) {
        
        let url = URL(string: baseUrl+path)
        if(url != nil){
            downloadImageData(from: url!) { data, response, error in
                guard let data = data, error == nil else { return }
                completion(data)
            }
        }
    }
    
    func downloadImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

