//
//  LabsDescriptionWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol LabsDescriptionWireFrameProtocol: class {
    
}

class LabsDescriptionWireFrame: BaseWireFrame {
    
    let navigationController: UINavigationController
    let viewController = LabsDescriptionViewController()
    
    let presenter: LabsDescriptionPresenterProtocol
    let interactor: LabsDescriptionInteractorProtocol
    
    override init() {
        let interactor = LabsDescriptionInteractor()
        let presenter = LabsDescriptionPresenter()
        
        self.presenter = presenter
        self.interactor = interactor
        
        viewController.presenterProtocol = presenter
        
        navigationController = UINavigationController(rootViewController: viewController)
        
        super.init()
        
        presenter.viewProtocol = viewController
        presenter.interactor = interactor
        presenter.router = self
    }
    
    func present(window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension LabsDescriptionWireFrame: LabsDescriptionWireFrameProtocol {
    
}