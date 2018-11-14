//
//  MKMapPoint+CGPoint.swift
//  GeoJSONMap
//
//  Created by Maxim Volgin on 10/11/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import CoreLocation
import MapKit

public extension MKMapPoint {

    public func normalized(in rect: MKMapRect) throws -> MKMapPoint {
        guard rect.contains(self) else {
            throw GJError.geometry("Point is not in rect!")
        }
        let normX = (self.x - rect.minX) / rect.width
        let normY = (self.y - rect.minY) / rect.height
        return MKMapPoint(x: normX, y: normY)
    }
    
    public func cgPoint(from rect: MKMapRect, to size: CGSize) throws -> CGPoint {
        let normalized = try self.normalized(in: rect)
        let newX = normalized.x * Double(size.width)
        let newY = Double(size.height) - normalized.y * Double(size.height)
        return CGPoint(x: newX, y: newY)
    }
    
}
