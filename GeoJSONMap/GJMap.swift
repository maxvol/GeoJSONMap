//
//  GJMap.swift
//  GeoJSONMap
//
//  Created by Maxim Volgin on 11/11/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import CoreLocation
import SpriteKit
import MapKit

// MARK: - map

public class GJMap {
    // private
    private var _features: [GJFeature] = []
    private var _mapRect: MKMapRect? = nil
    
    // public
    public func add(featureCollection: GJFeatureCollection) {
        _features.append(contentsOf: featureCollection.features)
        _mapRect = nil
    }
    public func add(feature: GJFeature) {
        _features.append(feature)
        _mapRect = nil        
    }
    public func remove(feature: GJFeature) {
        // TODO
//        _features.remove(feature)
        _mapRect = nil
    }
    public var features: [GJFeature] {
        get {
            return _features as Array<GJFeature>
        }
    }
    public var boundingMapRect: MKMapRect {
        get {
            if _mapRect == nil {
                _mapRect = MKMapRect.boundingMapRect(for: self.features)
            }
            return _mapRect!
        }
    }
    public var nodes: [SKNode] {
        get {
            return self.features.map { self.delegate?.map(self, nodeFor: $0) }.filter { $0 != nil }.map { $0! }
        }
    }
    public var delegate: GJMapDelegate?
}

// MARK: - delegate

public protocol GJMapDelegate {
    func map(_ map: GJMap, nodeFor feature: GJFeature) -> SKNode?
}
