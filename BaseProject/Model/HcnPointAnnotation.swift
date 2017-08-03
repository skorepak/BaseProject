//
//  HcnPointAnnotation.swift
//  BaseProject
//
//  Created by Jakub Skořepa on 03.08.17.
//  Copyright © 2017 Skorepak. All rights reserved.
//

import Foundation

class POI {
    let extra: Bool
    let title: String
    let subtitle: String
    let coordinates: CLLocationCoordinate2D
    
    init (extra: Bool, title: String, subtitle: String, coordinates: CLLocationCoordinate2D) {
        self.extra = extra
        self.title = title
        self.subtitle = subtitle
        self.coordinates = coordinates
    }
}

class HcnPointAnnotation: BMKPointAnnotation {
    var poi: POI?
}

class HcnPoiView: BMKPinAnnotationView {
    var poi: POI?
}
