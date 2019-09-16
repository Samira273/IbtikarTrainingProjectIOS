//
//  ImageViewController.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/5/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import UIKit

class ShowImageScreenView: UIViewController, ShowImageScreenViewProtocol {
    
    @IBAction func goBackToCollection(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveImage(_ sender: Any) {
        
        if(myImageView.image != nil){
            UIImageWriteToSavedPhotosAlbum(myImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @IBOutlet private weak var myImageView: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let renderImageScreen : (Data, String)-> Void = {(data , url) in
//            DispatchQueue.main.async{
//                self.myImageView.image = UIImage(data: data)
//            }
//        }
//        imageScreenFetchModel.imageFromUrl(urlString: baseUrl + path, completion: renderImageScreen)
        
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
}

//extension UIImageView {
//    public func imageFromUrl(urlString: String ) {
//
//        let url = URL(string: urlString)
//        if(url != nil){
//            downloadImageData(from: url!) { data, response, error in
//                guard let data = data, error == nil else { return }
//                DispatchQueue.main.async() {
//                    self.image = UIImage(data: data)
//                }
//            }
//        }
//    }
//
//    func downloadImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//
//}
//
