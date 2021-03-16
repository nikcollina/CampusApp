//
//  LocationConstants.swift
//  Campus
//
//  Created by Nikolas Collina on 10/9/20.
//

import Foundation
import MapKit
import CoreLocation

struct LocationConstants {
    static let userSpan : CLLocationDegrees = 0.005
    static let zoomSpan : CLLocationDegrees = 0.01
    static let regularSpan : CLLocationDegrees = 0.018
    static let initialCoordinate = CLLocationCoordinate2D(latitude: 40.800500, longitude: -77.863000)
}
