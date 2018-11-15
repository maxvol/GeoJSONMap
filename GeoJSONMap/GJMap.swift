//
//  GeoJSONMap.swift
//  GJMap
//
//  Created by Maxim Volgin on 11/11/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import CoreLocation
import SpriteKit
import MapKit

// MARK: - map
public class GJMap<D: GJMapDelegate> {
    // private
    private var _features: [GJFeature<D.P>] = []
    private var _mapRect: MKMapRect? = nil
    // public
    public init() {}
    public func add(featureCollection: GJFeatureCollection<D.P>) {
        _features.append(contentsOf: featureCollection.features)
        _mapRect = nil
    }
    public func add(feature: GJFeature<D.P>) {
        _features.append(feature)
        _mapRect = nil
    }
    public func remove(feature: GJFeature<D.P>) {
        // TODO
        //        _features.remove(feature)
        _mapRect = nil
    }
    public var features: [GJFeature<D.P>] {
        get {
            return _features as Array<GJFeature<D.P>>
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
    public var delegate: D?
}

// MARK: - delegate
public protocol GJMapDelegate {
    associatedtype P: Codable
    func map(_ map: GJMap<Self>, nodeFor feature: GJFeature<P>) -> SKNode?
}
