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
//
//            // Initialize the refresh control.
//
////            self.myRefreshControler.backgroundColor = [UIColor, purpleColor];
////            self.myRefreshControler.tintColor = [UIColor whiteColor];
//            self.myRefreshControler.backgroundColor = UIColor.purple
//            self.myRefreshControler.tintColor = UIColor.white
//
////            [self.refreshControl, addTarget:self option:@selector(getLatestLoans) forControlEvents:UIControlEventValueChanged];
//
//            self.myRefreshControler.attributedTitle = NSAttributedString(string: "Pull to refresh")
//            self.myRefreshControler.addTarget(self, action: #selector(self.refresh(_:) ), for: UIControl.Event.valueChanged)
            
            self.refreshControl?.addTarget(self, action: Selector(("refresh:")), for: UIControl.Event.valueChanged)
            
            
            getData(page: pageNo)
            
            
      }
//
//      @objc func refresh(sender:AnyObject) {
//            // Code to refresh table view
//            print(pageNo)
//      }
//
     
      

      
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
            return arrayOfPersons.count
      }
      
      override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(100)
      }
      
      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            activity.isHidden = true
            activity.stopAnimating()
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            //        uiImageview = cell.viewWithTag(1) as? UIImageView
            uiLable = cell.viewWithTag(2) as? UILabel
            if(arrayOfPersons[indexPath.row].path != nil){
                  
            let urlString = "https://image.tmdb.org/t/p/w500/"+arrayOfPersons[indexPath.row].path!
            
            getImage(str: urlString , indx: indexPath)
            
            uiLable.text = arrayOfPersons[indexPath.row].name
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







