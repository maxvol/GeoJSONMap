//
//  MKMapSize+CGSize.swift
//  GeoJSONMap
//
//  Created by Maxim Volgin on 10/11/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import CoreLocation
import MapKit

public extension MKMapSize {
    
    public var cgSize: CGSize {
        return CGSize(width: self.width, height: self.height)
    }
    
}
