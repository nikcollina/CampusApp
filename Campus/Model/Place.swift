//
//  Place.swift
//  Campus
//
//  Created by Nikolas Collina on 10/9/20.
//

import Foundation
import MapKit

struct Place :Identifiable {
    var category : String
    var placemark : MKPlacemark
    var id = UUID()
    var placeName : String
    var name : String {category == "empty" ? "" : placemark.name ?? "No Name"}
    var coordinate : CLLocationCoordinate2D {placemark.location!.coordinate}
    
    init(mapItem:MKMapItem, category:String, name: String) {
        self.category = category
        self.placemark = mapItem.placemark
        self.placeName = name
    }
    
    init(category:String, placemark:MKPlacemark, name: String) {
        self.category = category
        self.placemark = placemark
        self.placeName = name
    }
    
    
    static let empty = Place(mapItem: MKMapItem(), category: "empty", name: "none")
}
