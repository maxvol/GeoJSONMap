//
//  GJError.swift
//  GeoJSONMap
//
//  Created by Maxim Volgin on 14/11/2018.
//  Copyright © 2018 Maxim Volgin. All rights reserved.
//

import Foundation

public enum GJError: Error {
    case element(String)
    case geometry(String)
}
