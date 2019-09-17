//
//  ShowImageScreenPresenter.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/16/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation
class ShowImageScreenPresenter {
    private var showImageScreenModel : ShowImageScreenModelProtocol
    private var showImageScreenView : ShowImageScreenViewProtocol
    
    init(viewProtocol : ShowImageScreenViewProtocol , modelProtocol : ShowImageScreenModelProtocol) {
        self.showImageScreenView = viewProtocol
        self.showImageScreenModel = modelProtocol
    }
    
    func downloadImageData(){
        let updateView : (Data) -> Void = { (data) in
            self.showImageScreenView.setImage(data : data)
        }
        showImageScreenModel.imageFromUrl(completion : updateView )
    }
}
