//
//  UploaedImageViewController.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 10/13/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import UIKit
import Photos
import Alamofire
import OAuthSwift
import SwiftyXMLParser



class UploaedImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var chooseBtn: UIButton!
    var imagePicker = UIImagePickerController()
    var oauthSwift: OAuth1Swift?
    var oauthToken : String?
    var oauthTokenSecret : String?
    var userName : String?
    var userId : String?
    
    @IBAction func btnClicked() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission()
        imagePicker.delegate = self
       
        // Do any additional setup after loading the view.
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized: print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (newStatus) in print("status is \(newStatus)")
                if newStatus == PHAuthorizationStatus.authorized {  print("success") } })
                case .restricted:  print("User do not have access to photo album.")
        case .denied:  print("User has denied the permission.") @unknown default:
            fatalError("err")
        } }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        imageView.image = selectedImage
    
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(_ sender: Any) {
         authenticateUser()
    }
    

    
    func authenticateUser(){
        oauthSwift = OAuth1Swift(
            consumerKey: "88061f852ed398e0a88f67ab0fbc5cee",
            consumerSecret: "4776ce54a1c97111",
            requestTokenUrl:"https://www.flickr.com/services/oauth/request_token",
            authorizeUrl: "https://www.flickr.com/services/oauth/authorize",
            accessTokenUrl: "https://www.flickr.com/services/oauth/access_token"
        )
        
        _ = oauthSwift?.authorize(
        withCallbackURL: URL(string: "oauth-swift://oauth-callback/flickr")!) { result in
            switch result {
            case .success(let (credential, response, parameters)):
                
                let image = self.imageView.image
                guard let data = image?.jpegData(compressionQuality: 0.8) else {return}
                let fileData = OAuthSwiftMultipartData(name: "photo", data: data , fileName: "imageeeeeeee", mimeType: "png")
                let multiparts = [fileData]
               let client = OAuthSwiftClient(credential: credential)
                client.postMultiPartRequest("https://up.flickr.com/services/upload/", method: .POST, parameters: parameters, headers: nil, multiparts: multiparts, checkTokenExpiration: true, completionHandler: { uploadResult in
                    switch uploadResult{
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let success):
                       let xml = XML.parse(success.data)
                       if let pid = xml["rsp" , "photoid"].text{
                        print(pid)
                        }
                        
                    }
                })
            // Do your request
            case .failure(let error):
                switch error {
                case .retain:
                    print("tokrn expired")
                default:
                    break
                }
                print(error.localizedDescription)
            }
        }
        
        
    }


}
