//
//  TableViewController.swift
//  IbtikarProject
//
//  Created by Lost Star on 9/2/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
      
      var arrayOfPersons : [Person] = []
      var uiLable : UILabel!
      var uiImageview : UIImageView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()


    }
      
      
      func getImage(str : String , indx : IndexPath){
            
            let session = URLSession.shared
            let url = URL(string : str)
            
            let imageTask = session.dataTask(with: url!, completionHandler: { data, response, error in
                  if(data != nil){

                              DispatchQueue.main.async {
                                    let currentCell = self.tableView.cellForRow(at: indx)
                                    self.uiImageview = currentCell?.viewWithTag(1) as? UIImageView
                                    self.uiImageview?.image = UIImage(data: data!)
                                    self.tableView.reloadData()
                              }
                  }else {
                       
                        DispatchQueue.main.async{
                              self.uiImageview?.image = UIImage(named: "avatar.png")
                              self.tableView.reloadData()
                        }
                  }
            })
            imageTask.resume()
      }
    
    func getData(){
      
      
        let session = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/person/popular?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&page=1")!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

            
            do {
                  if (data != nil ){
                        // imageview.image = UIImage(data)
                  let jsonObject = try JSONSerialization.jsonObject(with: data!)
                  let dictionary = jsonObject as? NSDictionary
                  let results = dictionary?["results"] as? [NSDictionary]
                  for result in results!{
                        let person = Person()
                        person.id = result["id"] as? Int
                        person.name = result["name"] as? String
                        person.popularity = result["popularity"] as? Double
                        person.path = result["profile_path"] as? String
                        self.arrayOfPersons.append(person)
                        }
                  DispatchQueue.main.async {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
//        uiImageview = cell.viewWithTag(1) as? UIImageView
        uiLable = cell.viewWithTag(2) as? UILabel
        let urlString = "https://image.tmdb.org/t/p/w500/"+arrayOfPersons[indexPath.row].path!
      
        getImage(str: urlString , indx: indexPath)
     
        uiLable.text = arrayOfPersons[indexPath.row].name
      
      
      
      
        return cell
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







