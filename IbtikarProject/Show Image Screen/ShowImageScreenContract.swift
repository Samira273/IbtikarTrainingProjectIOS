//
//  ShowImageScreenContract.swift
//  IbtikarProject
//
//  Created by Samira.Marassy on 9/16/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import Foundation
protocol ShowImageScreenViewProtocol{
    func setImage(data : Data)->Void
}

protocol ShowImageScreenModelProtocol{
     func imageFromUrl(completion : @escaping (Data)-> Void)
}
