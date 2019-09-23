//
//  TableViewController.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/2/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import UIKit

class HomeScreenView: UITableViewController, UISearchBarDelegate, HomeScreenViewProtocol {
      
      @IBOutlet weak var activity: UIActivityIndicatorView!
      @IBOutlet weak var searchBar: UISearchBar!
      private let myRefreshControler = UIRefreshControl()
      private var homeScreenPresenter: HomeScreenPresenter?
      
      override func viewDidLoad() {
            super.viewDidLoad()
            homeScreenPresenter = HomeScreenPresenter(viewProtocol: self, modelProtocol: HomeScreenModel())
            searchBar.delegate = self
            searchBar.showsCancelButton = true
            activity.isHidden = true
            self.myRefreshControler.attributedTitle = NSAttributedString(string: "Refreshing")
            myRefreshControler.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
            tableView.refreshControl = myRefreshControler
            homeScreenPresenter?.settingDefaultUrl()
            homeScreenPresenter?.bringAndRender(caller : "viewDidLoad")
      }
      
      func reloadHomeScreen(){
            self.tableView.reloadData()
      }
      
      func setActivity(status : Bool) -> Void{
            activity.isHidden = status
      }
      
      @objc func refresh(sender:AnyObject) {
            // Code to refresh table view
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
//            homeScreenPresenter?.settingPageNo(page: 1)
//            homeScreenPresenter?.bringAndRender(caller : "refresh")
            homeScreenPresenter?.refreshSelected()
            self.refreshControl?.endRefreshing()
      }
      
      // MARK: - Table view data source
      
      override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
      }
      
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return homeScreenPresenter?.getNumberOfCells() ?? 0
      }
      
      override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(100)
      }
      
      func activityAction(action: String)->Void{
            if(action == "start"){
                  activity.startAnimating()
            }
            else if (action == "stop"){ activity.stopAnimating()
            }
      }
      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            homeScreenPresenter?.checkToLoadMore(index: indexPath.row)
            activity.isHidden = true
            activity.stopAnimating()
            let cell : HomeScreenCell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeScreenCell
            cell.imageView?.image = UIImage(named: "avatar")
            let renderImage : (Data , String) -> Void = { (data , url) in
                  DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: data)
                        
                  }
            }
            homeScreenPresenter?.getCellImageAtIndex(index: indexPath.row, completion: renderImage)
            cell.cellLabel.text = homeScreenPresenter?.getCellLabelAtIndex(index: indexPath.row)
            return cell
      }
      
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            var detailsModel = DetailsScreenModel()
            if let detailsScreenModel = homeScreenPresenter?.createNextModel(index: indexPath.row){
                  detailsModel = detailsScreenModel
            }
            let detailsView : DetailsScreenView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsVC") as! DetailsScreenView
            let detailsPresenter = DetailsScreenPresenter(viewProtocol: detailsView, modelProtocol: detailsModel)
            detailsView.setPresenter(presnter: detailsPresenter)
            self.present(detailsView, animated: true, completion: nil)
      }
      
      // MARK: - SearchBar functions
      
      func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: false)
      }
      
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
            searchBar.text = ""
            homeScreenPresenter?.searchCancel()
      }
      
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            let searchKey = searchBar.text
            print(searchKey!)
            searchBar.setShowsCancelButton(true, animated: false)
            searchBar.resignFirstResponder()
            if let cancelButton : UIButton = searchBar.value(forKey: "_cancelButton") as? UIButton{
                  cancelButton.isEnabled = true
            }
            if(searchKey != nil){
                  homeScreenPresenter?.search(keyWord: searchKey)
            }
      }
      
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if (searchBar.text != nil){
                  homeScreenPresenter?.search(keyWord: searchBar.text)
            }else{
                  self.tableView.reloadData()
            }
      }
      
}
