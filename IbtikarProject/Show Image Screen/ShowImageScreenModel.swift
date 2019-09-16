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
    
    func setPath(part : String){
        self.path = part
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
    
}

