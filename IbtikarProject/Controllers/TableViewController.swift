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
      @IBOutlet weak var searchBar: UISearchBar!
      
      var dataFetchModel = DataFetchModel()
      var imageFetchModel = ImageFetchModel()
      var uiLable : UILabel!
      var uiImageview : UIImageView!
      var pageNo = 1
      let myRefreshControler = UIRefreshControl()
      let apiTotalPages = 500
      var searchWasDone : Bool = false
      var defaultURL = ""
      let peopleURL = "https://api.themoviedb.org/3/person/popular?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&page="
      var noOfCells = 0
      
      func bringAndRender(url : String, page : Int){
            let renderData: (Bool) -> Void = { onSuccess in
                  if(onSuccess){
                        print("data fetch completed")
                        DispatchQueue.main.async {
                              self.noOfCells = self.dataFetchModel.arrayOfPersons.count
                              self.tableView.reloadData()
                        }
                  }
            }
            dataFetchModel.loadDataOf(url: url, forPageNO: page, completion: renderData)
            
            
      }
      
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
            //            getData(pageNumber: 1, urlString: defaultURL)
            print("before calling fetch")
            //            dataFetchModel.loadDataOf(url: defaultURL, forPageNO: 1, completion: renderData)
            bringAndRender(url: defaultURL, page: 1)
            
            
            
            
      }
      
      @objc func refresh(sender:AnyObject) {
            // Code to refresh table view
            
            print("refresh is choosen")
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
            self.pageNo = 1
            bringAndRender(url: defaultURL, page: pageNo)
            self.refreshControl?.endRefreshing()
            
      }
      
      // MARK: - Table view data source
      
      override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
      }
      
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return noOfCells
      }
      
      override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(100)
      }
      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if indexPath.row == dataFetchModel.arrayOfPersons.count - 1 && pageNo <= apiTotalPages {
                  //show loader
                  pageNo += 1
                  activity.isHidden = false
                  activity.startAnimating()
                  if pageNo <= apiTotalPages{
                        bringAndRender(url: defaultURL, page: pageNo)
                  }
            }
            
            
            activity.isHidden = true
            activity.stopAnimating()
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            self.uiLable = cell.viewWithTag(2) as? UILabel
            self.uiImageview = cell.viewWithTag(1) as? UIImageView
            
            if dataFetchModel.arrayOfPersons[indexPath.row].path != nil  {
                  
                  let urlString = "https://image.tmdb.org/t/p/w500/"+dataFetchModel.arrayOfPersons[indexPath.row].path!
                  
                  let renderImage : (Data , String) -> Void = { (data , url) in
                        DispatchQueue.main.async {
                              if url == urlString{
                                    self.uiImageview.image = UIImage(data: data)
                              }
                        }
                  }
                  imageFetchModel.imageFromUrl(urlString: urlString, completion: renderImage)
            }else{
                  self.uiImageview.image = UIImage(named: "avatar")
            }
            self.uiLable.text = dataFetchModel.arrayOfPersons[indexPath.row].name
            return cell
      }
      
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let detailsVC : DetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
            detailsVC.per = dataFetchModel.arrayOfPersons[indexPath.row]
            self.present(detailsVC, animated: true, completion: nil)
      }
      
      // MARK: - SearchBar functions
      
      func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            //            searchActive = false;
            searchBar.setShowsCancelButton(true, animated: false)
      }
      
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            print("cancel was selected")
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
            searchBar.text = ""
            self.pageNo = 1
            dataFetchModel.arrayOfPersons = []
            bringAndRender(url: peopleURL, page: 1)
      }
      
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
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
                  let searchUrl = "https://api.themoviedb.org/3/search/person?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&query=\(searchKey?.replacingOccurrences(of: " ", with: "%20") ?? "")&include_adult=false&page="
                  bringAndRender(url: searchUrl, page: 1)
                  tableView.reloadData()
            }
      }
      
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            if (searchBar.text != nil){
                  let searchURL = "https://api.themoviedb.org/3/search/person?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&query=\(searchText.replacingOccurrences(of: " ", with: "%20"))&include_adult=false&page="
                  defaultURL = searchURL
                  pageNo = 1
                  bringAndRender(url: searchURL, page: 1)
                  self.tableView.reloadData()
            }else{
                  self.tableView.reloadData()
            }
      }

}
