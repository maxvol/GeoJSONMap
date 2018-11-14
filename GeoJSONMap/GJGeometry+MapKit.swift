//
//  GJGeometry+MapKit.swift
//  GeoJSONMap
//
//  Created by Maxim Volgin on 11/11/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import CoreLocation
import SpriteKit
import MapKit

public extension GJGeometry {
    
//    public var coordinate: CLLocationCoordinate2D {
//        get {
//            switch self {
//            case .point(let coordinate):
//                return coordinate
//            case .lineString(let coordinates):
//                return coordinates.first! // TODO
//            }
//        }
//    }
    
    public var boundingMapRect: MKMapRect {
        get {
            return MKMapRect.boundingMapRect(for: self)
        }
    }
    
}
