//
//  GeoJSON.swift
//  GeoJSONMap
//
//  Created by Maxim Volgin on 26/04/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import CoreLocation

fileprivate enum GeoJSON: String {
    case Feature = "Feature"
    // TODO
}

public struct GJFeatureCollection<P: Codable>: Codable {
    public let type: String
    public let features: [GJFeature<P>]
}

public struct GJFeature<P: Codable> {
    public let id: Int
    public let geometry: GJGeometry
    public let properties: P
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id
        case type
        case geometry
        case properties
    }
    
}

extension GJFeature: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //        try container.encode(name, forKey: .name)
    }
}

extension GJFeature: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try values.decode(String.self, forKey: .type)
        guard type == GeoJSON.Feature.rawValue else {
            throw GJError.element("Unexpected type: \(type)")
        }
        self.id = try values.decode(Int.self, forKey: .id)
        self.geometry = try values.decode(GJGeometry.self, forKey: .geometry)
        self.properties = try values.decode(P.self, forKey: .properties)
    }
}

public enum GJGeometry {
    case point(CLLocationCoordinate2D)
    case lineString([CLLocationCoordinate2D])
    
    fileprivate enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
    
    fileprivate enum Element: String {
        case Point = "Point"
        case LineString = "LineString"
        // TODO
    }
}

// TODO
extension GJGeometry: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //        try container.encode(name, forKey: .name)
    }
}

extension GJGeometry: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try values.decode(String.self, forKey: .type)
        switch type {
        case Element.Point.rawValue:
            let coordinates = try values.decode([CLLocationDegrees].self, forKey: .coordinates)
            guard coordinates.count == 2 else {
                throw GJError.geometry("coordinates count: \(coordinates.count)")
            }
            self = .point(CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0]))
        case Element.LineString.rawValue:
            let coordinates = try values.decode([[CLLocationDegrees]].self, forKey: .coordinates)
            self = try .lineString(coordinates.map { coordinates in
                guard coordinates.count == 2 else {
                    throw GJError.geometry("coordinates count: \(coordinates.count)")
                }
                return CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
            })
        default:
            throw GJError.geometry("Unexpected type: \(type)")
        }
    }
}

//GeoJSONPolygon.type: GeoJSONPolygon.self,
//GeoJSONMultiPoint.type: GeoJSONMultiPoint.self,
//GeoJSONMultiPolygon.type: GeoJSONMultiPolygon.self,
//GeoJSONMultiLineString.type: GeoJSONMultiLineString.self

