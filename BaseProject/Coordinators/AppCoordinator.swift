//
//  AppCoordinator.swift
//  BaseProject
//
//  Created by Skorepa on 12.07.2017.
//  Copyright © 2017 Skorepak. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    static let instance = AppCoordinator()
    
    private init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        super.init(window: window)
        self.window.makeKeyAndVisible()
    }
    
    func begin() {
        let vc = MapViewController(coordinator: self)
        push(vc)
    }
}

extension AppCoordinator: MapViewControllerCoordinator {
    
}
