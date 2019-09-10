//
//  TableViewController.swift
//  IbtikarProject
//
//  Created by Lost Star on 9/2/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
      @IBOutlet weak var activity: UIActivityIndicatorView!
      
      var arrayOfPersons : [Person] = []
      var uiLable : UILabel!
      var uiImageview : UIImageView!
     // var isDataLoading:Bool=false
      var pageNo = 1
      let myRefreshControler = UIRefreshControl()
      var apiTotalPages : Int?
      var searchWasDone : Bool = false
      var defaultURL = ""
      let peopleURL = "https://api.themoviedb.org/3/person/popular?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&page="
      
      @IBOutlet weak var searchBar: UISearchBar!
      
      
      
//      func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//
////            searchActive = true;
//      }

      func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            //            searchActive = false;
            searchBar.setShowsCancelButton(true, animated: false)
      }
      //
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            //            searchActive = false;
            print("cancel was selected")
            
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
            searchBar.text = ""
            self.pageNo = 1
            arrayOfPersons = []
            
            getData(pageNumber: 1, urlString: peopleURL)
            
            self.tableView.reloadData()
      }

      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

//            searchActive = false;
            print("search bar has been clicked")
            
            searchWasDone = true
            let searchKey = searchBar.text
            print(searchKey!)
            searchBar.setShowsCancelButton(true, animated: false)
            searchBar.resignFirstResponder()
            if let cancelButton : UIButton = searchBar.value(forKey: "_cancelButton") as? UIButton{
                  cancelButton.isEnabled = true
            }
            
            if(searchKey != nil){
//                  let searchUrl = "https://api.themoviedb.org/3/search/person?api_key=facd2bc8ee066628c8f78bbb7be41943&query="+searchKey!
                  
                  let searchUrl = "https://api.themoviedb.org/3/search/person?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&query=\(searchKey?.replacingOccurrences(of: " ", with: "%20") ?? "")&include_adult=false&page="
                  
                  getData(pageNumber: 1, urlString: searchUrl)
                  tableView.reloadData()
                  
            }
//            else{
//                  getData(pageNumber: 1, urlString: peopleURL)
//            }
      }
      
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            //remove spaces
            if (searchBar.text != nil){
                  let searchURL = "https://api.themoviedb.org/3/search/person?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&query=\(searchText.replacingOccurrences(of: " ", with: "%20"))&include_adult=false&page="
                  defaultURL = searchURL
                  pageNo = 1
                  getData(pageNumber: 1, urlString: searchURL)
                  self.tableView.reloadData()
            }else{
                  self.tableView.reloadData()
            }
            
            
      }
      
      
      
//      https://api.themoviedb.org/3/search/person?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&query=Dd&include_adult=false&page=1
//
//
      override func viewDidLoad() {
            super.viewDidLoad()
            searchBar.delegate = self
         
            searchBar.showsCancelButton = true
            
            activity.isHidden = true
            
            self.myRefreshControler.attributedTitle = NSAttributedString(string: "Refreshing")
            
            myRefreshControler.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
            tableView.refreshControl = myRefreshControler
            
            //   arrayOfPersons.removeAll()
            
            defaultURL = peopleURL
            getData(pageNumber: 1, urlString: defaultURL)
      }
      
      @objc func refresh(sender:AnyObject) {
            // Code to refresh table view
            
            print("refresh is choosen")
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
            self.pageNo = 1
         //   self.isDataLoading = false
            getData(pageNumber: pageNo, urlString: defaultURL)
            self.refreshControl?.endRefreshing()
            
      }
      
      
      
      func getData(pageNumber : Int , urlString :String){
            
            
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
                                          
                                          //                                          self.pageNo = dictionary?["page"] as? Int ?? 1
                                          for result in results{
                                                
                                                let person = Person()
                                                person.id = result["id"] as? Int
                                                person.name = result["name"] as? String
                                                person.popularity = result["popularity"] as? Double
                                                person.path = result["profile_path"] as? String
                                                self.arrayOfPersons.append(person)
                                          }
                                          self.pageNo += 1
                                          //    self.isDataLoading = false
                                          print ("the global page no is\(self.pageNo-1) totalpages is \(self.apiTotalPages ?? 0)")
                                          
                                          print("\(self.arrayOfPersons.count)")
                                          self.tableView.reloadData()
                                          
                                    }
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
           // if let no = apiTotalPages{
            
            if indexPath.row == arrayOfPersons.count - 1 && pageNo <= apiTotalPages! {
                  
                  
                  //show loader
                  activity.isHidden = false
                  activity.startAnimating()
                  //  self.isDataLoading = true
                  if pageNo <= apiTotalPages!{
                        getData(pageNumber: pageNo, urlString: defaultURL)
                  }
            }
   //   }
            
            activity.isHidden = true
            activity.stopAnimating()
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            self.uiLable = cell.viewWithTag(2) as? UILabel
            self.uiImageview = cell.viewWithTag(1) as? UIImageView
            
            if arrayOfPersons[indexPath.row].path != nil  {
                  
                  let urlString = "https://image.tmdb.org/t/p/w500/"+arrayOfPersons[indexPath.row].path!
                  //                  let url = URL(string: urlString)
                  uiImageview.imageFromUrl(urlString: urlString)
            }else{
                  self.uiImageview.image = UIImage(named: "avatar")
            }
                  self.uiLable.text = self.arrayOfPersons[indexPath.row].name
//
//            if(arrayOfPersons[indexPath.row].path != nil){
//
//                  let urlString = "https://image.tmdb.org/t/p/w500/"+arrayOfPersons[indexPath.row].path!
//                  let url = URL(string: urlString)
//
//                  if (url != nil){
//
//                        self.uiLable.text = self.arrayOfPersons[indexPath.row].name
//                        uiImageview.imageFromUrl(urlString: urlString)
//
//
//                        //                        setImage(from: url!, indx: indexPath)
//                        //                        DispatchQueue.global().async {
//                        //                              let data = try? Data(contentsOf: url!)
//                        //                              DispatchQueue.main.async {
//                        //
//                        //                                    let cell = self.tableView.cellForRow(at: indexPath)
//                        //                                    self.uiImageview = cell?.viewWithTag(1) as? UIImageView
//                        //                                    self.uiLable = cell?.viewWithTag(2) as? UILabel
//                        //                                    if(data != nil){
//                        //                                          self.uiImageview.image = UIImage(data: data!)
//                        //                                          self.uiLable.text = self.arrayOfPersons[indexPath.row].name
//                        //                                    }
//                        //
//                        //                              }
//                  }
//            }
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
          

            
      }
      
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







