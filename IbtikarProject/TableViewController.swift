//
//  TableViewController.swift
//  IbtikarProject
//
//  Created by Lost Star on 9/2/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
      @IBOutlet weak var activity: UIActivityIndicatorView!
      
      var arrayOfPersons : [Person] = []
      var uiLable : UILabel!
      var uiImageview : UIImageView!
      var isDataLoading:Bool=false
      var pageNo:Int=1
      let myRefreshControler = UIRefreshControl()
      
      override func viewDidLoad() {
            super.viewDidLoad()
            
            activity.isHidden = true

          self.myRefreshControler.attributedTitle = NSAttributedString(string: "Refreshing")
            
            myRefreshControler.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
            tableView.refreshControl = myRefreshControler
            
            
            getData(page: pageNo)
            
            
      }

      @objc func refresh(sender:AnyObject) {
            // Code to refresh table view
            
            print("refresh is choosen")
            arrayOfPersons.removeAll()
            self.pageNo = 1
            self.isDataLoading = false
            getData(page: pageNo)
            self.refreshControl?.endRefreshing()
            
      }

     
      

      
          func getImage(str : String , indx : IndexPath){
            
//            let session = URLSession.shared
//            let url = URL(string : str)
//
//            let imageTask = session.dataTask(with: url!, completionHandler: { data, response, error in
//                  if(data != nil){
//
//                        DispatchQueue.main.async {
//                              let currentCell = self.tableView.cellForRow(at: indx)
//                              self.uiImageview = currentCell?.viewWithTag(1) as? UIImageView
//                              self.uiImageview?.image = UIImage(data: data!)
//                              self.tableView.reloadData()
//                        }
//                  }else {
//
//                        DispatchQueue.main.async{
//                              self.uiImageview?.image = UIImage(named: "avatar.png")
//                              self.tableView.reloadData()
//                        }
//                  }
//            })
//            imageTask.resume()
      }
      
      
      
//    func downloadImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
////            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
////      }
//
//
//      func setImage(from url: URL, indx : IndexPath){
//
//            downloadImageData(from: url) { data, response, error in
//                  guard let data = data, error == nil else { return }
//                  DispatchQueue.main.async() {
//                        let currentCell = self.tableView.cellForRow(at: indx)
//                        self.uiImageview = currentCell?.viewWithTag(1) as? UIImageView
//                        currentCell?.imageView?.image = UIImage(data: data)
//                        self.tableView.reloadData()
//                  }
//            }
//      }
      
      
      
      func getData(page : Int){
            
            
            let session = URLSession.shared
            let url = URL(string: "https://api.themoviedb.org/3/person/popular?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&page="+"\(page)")!
            print(page)
            
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                  
                  
                  do {
                        if (data != nil ){
                             
                              let jsonObject = try JSONSerialization.jsonObject(with: data!)
                              let dictionary = jsonObject as? NSDictionary
                              
                              
                              DispatchQueue.main.async {
                                    
                                    let results = dictionary?["results"] as? [NSDictionary]
                                    
                                    for result in results!{
                                          
                                          let person = Person()
                                          person.id = result["id"] as? Int
                                          person.name = result["name"] as? String
                                          person.popularity = result["popularity"] as? Double
                                          person.path = result["profile_path"] as? String
                                          self.arrayOfPersons.append(person)
                                    }
                                    self.pageNo += 1
                                    self.isDataLoading = false
                                    self.tableView.reloadData()
                              }
                              
                        }
                        
                        
                  } catch {
                        print("JSON error: \(error.localizedDescription)")
                  }
            })
            
            
            task.resume()
      }
      
      // MARK: - Table view data source
      
      override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
      }
      
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            print("no of persons is \(arrayOfPersons.count)")
            return arrayOfPersons.count
      }
      
      override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(100)
      }
      
      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            activity.isHidden = true
            activity.stopAnimating()
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            self.uiLable = cell.viewWithTag(2) as? UILabel
            self.uiImageview = cell.viewWithTag(1) as? UIImageView
            
            if(arrayOfPersons[indexPath.row].path != nil){
                  
            let urlString = "https://image.tmdb.org/t/p/w500/"+arrayOfPersons[indexPath.row].path!
            let url = URL(string: urlString)
                  
                  if (url != nil){
                        
                        self.uiLable.text = self.arrayOfPersons[indexPath.row].name
                        uiImageview.imageFromUrl(urlString: urlString)
                         
                        
//                        setImage(from: url!, indx: indexPath)
//                        DispatchQueue.global().async {
//                              let data = try? Data(contentsOf: url!)
//                              DispatchQueue.main.async {
//
//                                    let cell = self.tableView.cellForRow(at: indexPath)
//                                    self.uiImageview = cell?.viewWithTag(1) as? UIImageView
//                                    self.uiLable = cell?.viewWithTag(2) as? UILabel
//                                    if(data != nil){
//                                          self.uiImageview.image = UIImage(data: data!)
//                                          self.uiLable.text = self.arrayOfPersons[indexPath.row].name
//                                    }
//
//                              }
//                        }
                  }
            }
            
            return cell
            
      }
      
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //            self.performSegue(withIdentifier: "goToDetails", sender: self)
            
            let detailsVC : DetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
            
            //            let detailsVC : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
            detailsVC.per = arrayOfPersons[indexPath.row]
            
            self.present(detailsVC, animated: true, completion: nil)
      }
      
      
      
      override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            // check if the last element
            if indexPath.row == arrayOfPersons.count - 1 && !isDataLoading{
                  
                  
                  //show loader
                  activity.isHidden = false
                  activity.startAnimating()
                  self.isDataLoading = true
                  
                  getData(page: pageNo)
            }
            
      }
      /*
       // Override to support conditional editing of the table view.
       override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       // Return false if you do not want the specified item to be editable.
       return true
       }
       */
      
      /*
       // Override to support editing the table view.
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
       // Delete the row from the data source
       tableView.deleteRows(at: [indexPath], with: .fade)
       } else if editingStyle == .insert {
       // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       }
       }
       */
      
      /*
       // Override to support rearranging the table view.
       override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
       
       }
       */
      
      /*
       // Override to support conditional rearranging of the table view.
       override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
       // Return false if you do not want the item to be re-orderable.
       return true
       }
       */
      
      /*
       // MARK: - Navigation
       
       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
       }
       */
      
}

extension UIImageView {
      public func imageFromUrl(urlString: String ) {
            
            let url = URL(string: urlString)
            
            if(url != nil){
                  
              downloadImageData(from: url!) { data, response, error in
              guard let data = data, error == nil else { return }
                  DispatchQueue.main.async() {
                             self.image = UIImage(data: data)
                        
                                    }
                              }
            }
      }
      
      func downloadImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
                  URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
            }

}







