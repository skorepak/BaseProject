//
//  MapViewController.swift
//  BaseProject
//
//  Created by Jakub Skořepa on 27.07.17.
//  Copyright © 2017 Skorepak. All rights reserved.
//

import UIKit


protocol MapViewControllerCoordinator: BaseViewControllerCoordinator {
    
}

class MapViewController: BaseViewController {
    
    fileprivate unowned let coordinator: MapViewControllerCoordinator
    fileprivate let mapManager: BMKMapManager
    private var mapView: BMKMapView!
    
    init(coordinator: MapViewControllerCoordinator) {
        self.coordinator = coordinator
        
        mapManager = BMKMapManager()
        
        super.init(coordinator: coordinator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var mapPlaceholder: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapManager.start("KBGfIyD71VXdZ39xUREdeNpBgZX0UN9d", generalDelegate: self)
        mapView = BMKMapView(frame: mapPlaceholder.frame)
        mapPlaceholder.addSubview(mapView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.viewWillDisappear()
    }
    
    func createPoi() {
        //let x = BMKMapPoint
    }
    
}

extension MapViewController: BMKGeneralDelegate {
    
}
