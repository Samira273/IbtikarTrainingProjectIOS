//
//  DetailsViewController.swift
//  IbtikarProject
//
//  Created by Lost Star on 9/3/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var myCollectionView: UICollectionView!
   
    var arrayOfPaths : [String] = []
    var uiImageSub : UIImageView!
    var uiImageMain : UIImageView!
    var uiLableMain : UILabel!
   
    var per = Person()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("no of paths ====>\(arrayOfPaths.count)")
        return arrayOfPaths.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCell", for: indexPath)
        
        print("subcell")
       

        let urlString = "https://image.tmdb.org/t/p/w500/"+arrayOfPaths[indexPath.row]
            
          print(urlString + " url for subimage")
            getImage(str: urlString , indx: indexPath, type: "subCell")
            
     
      
        return cell
        
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "mainCell", for: indexPath)


        uiLableMain = cell.viewWithTag(2) as? UILabel
        uiLableMain.text = per.name
        let urlString = "https://image.tmdb.org/t/p/w500/"+per.path!
        print(urlString + "url for main image")
        getImage(str: urlString, indx: indexPath, type: "mainCell")
        return cell
    }
    
   
    
   
    @IBAction func goBack(_ sender: Any) {
    
        self.dismiss(animated: true, completion: nil)
    }
    
    
  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPaths()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
       
       // print(arrayOfProfiles[0].filePath ?? "default value")
      self.myCollectionView.reloadData()
       
    }
    

    
    
    func getImage(str : String , indx : IndexPath, type : String){
        
        let session = URLSession.shared
        let url = URL(string : str)
        
        let imageTask = session.dataTask(with: url!, completionHandler: { data, response, error in
            if(data != nil){
                
              
                
                DispatchQueue.main.async {
                    
                    if(type=="subCell"){
                   
                            let currentCell = self.myCollectionView.cellForItem(at: indx)
                            self.uiImageSub = currentCell?.viewWithTag(3) as? UIImageView
                        if ( data != nil){
                                self.uiImageSub.image = UIImage(data: data!)
//                            self.myCollectionView.insertItems(at: [indx])
//                                self.myCollectionView.reloadData()
                        }
                    
                        
                    }  else if(type=="mainCell"){
                
                   
                        let current = self.myCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indx)
                        self.uiImageMain = current?.viewWithTag(1) as? UIImageView
                        
                        if(data != nil){
                                self.uiImageMain.image = UIImage(data: data!)
        //                        self.myCollectionView.reloadData()
                                self.myCollectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader)
                        }
                    }
                    
                
                    
                   
                }
            }else {
                
                DispatchQueue.main.async{
                   print("error loading data")
                }
            }
        })
        imageTask.resume()
    }
    
    func getPaths(){
        
        let str = "\(per.id ?? 0)"
      
        let url = URL(string : "https://api.themoviedb.org/3/person/"+str + "/images?api_key=6b93b25da5cdb9298216703c40a31832")!
        
        print(url)
        
        let session = URLSession.shared
        
        let pathsTask = session.dataTask(with: url , completionHandler: { data , response, error in
            
            
            do{
            
            if (data != nil ){
               
                
                let jsonObject = try JSONSerialization.jsonObject(with: data!)
                print(jsonObject)
                
                let dictionary = jsonObject as? NSDictionary
                let profiles = dictionary?["profiles"] as? [NSDictionary]
        
                for profile in profiles!{

                    let path = profile["file_path"] as? String
                    if (path != nil){
                         self.arrayOfPaths.append(path!)
                        }
                   
                    }
                DispatchQueue.main.async{
                   self.myCollectionView.reloadData()
                }
                
                }
            }catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        })
        
        pathsTask.resume()
    
    }

}
