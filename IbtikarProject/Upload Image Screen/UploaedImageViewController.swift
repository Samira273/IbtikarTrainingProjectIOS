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
import p2_OAuth2


class UploaedImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    let oauth2 = OAuth2CodeGrant(settings: [
        "client_id": "my_swift_app",
        "client_secret": "C7447242",
        "authorize_uri": "https://github.com/login/oauth/authorize",
        "token_uri": "https://github.com/login/oauth/access_token",   // code grant only
        "redirect_uris": ["myapp://oauth/callback"],   // register your own "myapp" scheme in Info.plist
        "scope": "user repo:status",
        "secret_in_body": true,    // Github needs this
        "keychain": false,         // if you DON'T want keychain integration
        ] as OAuth2JSON)

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var chooseBtn: UIButton!
    var imagePicker = UIImagePickerController()
    
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
        authenticateUser()
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
    }
    
    
    func authenticateUser(){
        oauth2.authConfig.authorizeEmbedded = true
        oauth2.authConfig.authorizeContext = self
        oauth2.logger = OAuth2DebugLogger(.trace)


    }
//    func application(_ app: UIApplication,
//                     open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
//        // you should probably first check if this is the callback being opened
////        if (oauth2) {
//            // if your oauth2 instance lives somewhere else, adapt accordingly
//            oauth2.handleRedirectURL(url)
////        }
//    }
    
//    func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
//
//        let url = "https://up.flickr.com/services/upload/" /* your API url */
//
//        let headers: HTTPHeaders = [
//            /* "Authorization": "your_access_token",  in case you need authorization header */
////            "oauth_token": "4d4eeaffeeadc6d7a88a8e2bc6bc0de6-d4bd66812fa179a2",
//            "Content-type": "multipart/form-data"
//        ]
//
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//
//            if let data = imageData{
//                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
//            }
//
//        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
//            switch result{
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    print("Succesfully uploaded")
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    onCompletion?(nil)
//                }
//            case .failure(let error):
//                print("Error in upload: \(error.localizedDescription)")
//                onError?(error)
//            }
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
