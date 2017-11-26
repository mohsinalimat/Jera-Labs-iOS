//
//  BasePresenter.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol BasePresenterProtocol {
    
}

class BasePresenter: BasePresenterProtocol {
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}
