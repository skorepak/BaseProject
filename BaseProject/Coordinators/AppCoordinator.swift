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
    let mapManager: BMKMapManager
    
    private init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        mapManager = BMKMapManager()
        mapManager.start("KBGfIyD71VXdZ39xUREdeNpBgZX0UN9d", generalDelegate: nil)
        
        super.init(window: window)
        self.window.makeKeyAndVisible()
        
        
    }
    
    func begin() {
        let vc = MapViewController(coordinator: self)
        push(vc)
    }
}

extension AppCoordinator: MapViewControllerCoordinator {
    func openDetail(poi: POI) {
        let vc = MapViewController(coordinator: self, poi: poi)
        push(vc)
    }

    
}
