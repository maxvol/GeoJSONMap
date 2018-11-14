//
//  GeoJSON.swift
//  GeoJSONMap
//
//  Created by Maxim Volgin on 26/04/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import CoreLocation

public struct GJFeatureCollection: Codable {
    let type: String
    let features: [GJFeature]
}

public struct GJFeature: Codable {
    let id: Int
    let type: String
    let geometry: GJGeometry
    let properties: Properties
//    let properties: [String: String]
}

public enum GJGeometry {
//    let type: String
//    let coordinates: [Double]
    case point(CLLocationCoordinate2D)
    case lineString([CLLocationCoordinate2D])

    fileprivate enum CodingKeys: String, CodingKey {
        case type // = "custom name"
        case coordinates
    }
    
    fileprivate static let Point = "Point"
    fileprivate static let LineString = "LineString"
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
        case GJGeometry.Point:
            let coordinates = try values.decode([CLLocationDegrees].self, forKey: .coordinates)
            guard coordinates.count == 2 else {
              throw GJError.geometry("coordinates count: \(coordinates.count)")
            }
            self = .point(CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0]))
        case GJGeometry.LineString:
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


