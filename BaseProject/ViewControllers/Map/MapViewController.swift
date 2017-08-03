//
//  MapViewController.swift
//  BaseProject
//
//  Created by Jakub Skořepa on 27.07.17.
//  Copyright © 2017 Skorepak. All rights reserved.
//

import UIKit


protocol MapViewControllerCoordinator: BaseViewControllerCoordinator {
    func openDetail(poi: POI)
}

class MapViewController: BaseViewController {
    
    fileprivate unowned let coordinator: MapViewControllerCoordinator
    private var mapView: BMKMapView!
    
    fileprivate let poi: POI?
    
    init(coordinator: MapViewControllerCoordinator, poi: POI? = nil) {
        self.poi = poi
        self.coordinator = coordinator
        super.init(coordinator: coordinator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var mapPlaceholder: UIView!
    @IBOutlet weak var subtitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = poi?.title ?? ""
        subtitle.text = poi?.subtitle ?? "Baidu maps SDK test"
        
        mapView = BMKMapView(frame: mapPlaceholder.bounds)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapPlaceholder.addSubview(mapView)
        
        mapView.zoomLevel = 17
        if poi != nil {
            mapView.gesturesEnabled = false
        }
        
        let pragueCoordinates = CLLocationCoordinate2DMake(50.094113, 14.446316)
        mapView.centerCoordinate = poi?.coordinates ?? pragueCoordinates
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(mapView.leadingAnchor.constraint(equalTo: mapPlaceholder.leadingAnchor))
        constraints.append(mapView.trailingAnchor.constraint(equalTo: mapPlaceholder.trailingAnchor))
        constraints.append(mapView.bottomAnchor.constraint(equalTo: mapPlaceholder.bottomAnchor))
        constraints.append(mapView.topAnchor.constraint(equalTo: mapPlaceholder.topAnchor))
        mapPlaceholder.addConstraints(constraints)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.viewWillAppear()
        mapView.delegate = self
        
        if let poi = poi {
           createPoi(poi)
        } else {
            let office = POI(extra: true, title: "Praha", subtitle: "\"Best place on earth\"", coordinates: CLLocationCoordinate2DMake(50.094113, 14.446316))
            let lokal = POI(extra: false, title: "Lokal", subtitle: "Český jídlo", coordinates: CLLocationCoordinate2DMake(50.093189, 14.446771))
            let church = POI(extra: false, title: "Kostel", subtitle: "Drž se dál", coordinates: CLLocationCoordinate2DMake(50.091338, 14.448121))
            
            createPoi(office)
            createPoi(lokal)
            createPoi(church)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mapView.viewWillDisappear()
        mapView.delegate = nil
    }
    
    func createPoi(_ poi: POI) {
        let pointAnnotation = HcnPointAnnotation()
        pointAnnotation.coordinate = poi.coordinates
        
        pointAnnotation.poi = poi
        pointAnnotation.title = poi.title
        pointAnnotation.subtitle = poi.subtitle
        
        mapView.addAnnotation(pointAnnotation)
    }
}

extension MapViewController: BMKMapViewDelegate {
    func mapViewDidFinishLoading(_ mapView: BMKMapView!) {
        print("A")
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        let AnnotationViewID = "renameMark"
        
        guard let point = annotation as? HcnPointAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationViewID) as! HcnPoiView?
        if annotationView == nil {
            annotationView = HcnPoiView(annotation: point, reuseIdentifier: AnnotationViewID)
        }
        annotationView!.poi = point.poi
        annotationView!.pinColor = point.poi!.extra ? UInt(BMKPinAnnotationColorRed) : UInt(BMKPinAnnotationColorGreen)
        annotationView!.animatesDrop = false
        annotationView!.isDraggable = true

        return annotationView
    }
    
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        guard poi == nil, let poiView = view as? HcnPoiView else { return }
        coordinator.openDetail(poi: poiView.poi!)
    }
}
