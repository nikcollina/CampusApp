//
//  LocationsManager.swift
//  Campus
//
//  Created by Nikolas Collina on 10/6/20.
//

import Foundation
import MapKit

class LocationsManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let locationManager : CLLocationManager
    @Published var showsUserLocation = true
    
    override init() {
        
        locationManager = CLLocationManager()
        
        let buildingManager = BuildingManager()
        buildings = buildingManager.buildings
        
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        for item in buildings{
            if item.favorite == true {
                favoriteUpdate(isFavorite: false, building: item)
            }
        }
        resetMapPosition()
        
        
        
    }
    
    
    let zoomSpan : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: LocationConstants.zoomSpan, longitudeDelta: LocationConstants.zoomSpan)
    let regularSpan : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: LocationConstants.regularSpan, longitudeDelta: LocationConstants.regularSpan)
    let userSpan : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: LocationConstants.userSpan, longitudeDelta: LocationConstants.userSpan)
    
    
    @Published var region = MKCoordinateRegion(center: LocationConstants.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: LocationConstants.regularSpan, longitudeDelta: LocationConstants.regularSpan))
    
    @Published var mappedPlaces = [Place]()
    
    @Published var lastMapped = Place.empty
    
    @Published var route : MKRoute?
    
    var buildings : [Building]
    
    var selectedBuilding : Int = 0 {
        didSet {
            plot(building: buildings[selectedBuilding])
        }
    }
    
    @Published var startBuilding : Int = 0
    @Published var endBuilding : Int = 0
    
    func getPlaceIndex(name: String) -> Int {
        var index = 0
        for item in mappedPlaces {
            if item.placeName == name {
                return index
            }
            index += 1
        }
        return -1
    }
    
    func favoriteUpdate(isFavorite : Bool, building : Building) {
        if isFavorite {
            let index = getPlaceIndex(name: building.name)
            if index > -1 {
                mappedPlaces.remove(at: index)
            }
            resetMapPosition()
        }
        else{
            if isPlotted(building: building) {
                let index = getPlaceIndex(name: building.name)
                mappedPlaces[index].category = "Favorite"
            }
            else {
                let mapMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude))
                let place = Place(category: "Favorite", placemark: mapMark, name: building.name)
                self.mappedPlaces.append(place)
                self.region.center = mapMark.coordinate
                self.region.span = zoomSpan
            }
        }
    }
    
    
    func plot(building : Building) {
        let mapMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude))
        let place = Place(category: "Plot", placemark: mapMark, name: building.name)
        let plotted = isPlotted(building: building)
        if plotted == false {
            self.mappedPlaces.append(place)
            
        }
        self.region.center = mapMark.coordinate
        self.region.span = zoomSpan
        lastMapped = place
    }
    
    func isPlotted(building: Building) -> Bool {
        for item in mappedPlaces {
            if item.placeName == building.name {
                return true
            }
        }
        return false
    }
    
    
    
    func clear() {
        if mappedPlaces.count > 0 {
            var index = 0
            for item in mappedPlaces{
                if item.category == "Plot" {
                    mappedPlaces.remove(at: index)
                    index -= 1
                }
                index += 1
            }
        }
        route = nil
        resetMapPosition()
        lastMapped = Place.empty
    }
    
    func getAnnotation(place: Place) -> String{
        if place.category == "Plot" {
            return "pin"
        }
        if place.category == "Favorite"{
            return "star.circle.fill"
        }
        else {
            return ""
        }
    }
    
    func resetMapPosition() {
        let mapMark = MKPlacemark(coordinate: LocationConstants.initialCoordinate)
        self.region.center = mapMark.coordinate
        self.region.span = regularSpan
    }
    
    
    
    //CLLocationManager Delegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation()
            showsUserLocation = false
        }
    }
    
    var currentLoctaion : CLLocationCoordinate2D?
    @Published var followingUser : Bool = false
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newCoordinates = locations.map {$0.coordinate}
        
        if let coordinate = newCoordinates.first {
            currentLoctaion = coordinate
            if followingUser {
                region.center = coordinate
                self.region.span = userSpan
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func centerUser() {
        if currentLoctaion != nil {
            region.center = currentLoctaion!
            region.span = userSpan
        }
    }
    
    
    //Directions
    
    var directionTypes = ["Current Location To Building", "Building to Building", "Building to Current Location"]
    @Published var currentDirectionType = 0
    
    func provideDirections(to:Int?, from:Int?, place:Place?) {
        
        let request = MKDirections.Request()
        
        if (place != nil) {
            request.source = MKMapItem.forCurrentLocation()
            request.destination = MKMapItem(placemark: place!.placemark)
        }
        
        else {
            if (currentDirectionType != 0) {
                let start = buildings[from!]
                let mapMarkFrom = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: start.latitude, longitude: start.longitude))
                let startPlace = Place(category: "Route", placemark: mapMarkFrom, name: start.name)
                request.source = MKMapItem(placemark: startPlace.placemark)
            }
            else {
                request.source = MKMapItem.forCurrentLocation()
            }
            
            if (currentDirectionType != 2) {
                let destination = buildings[to!]
                let mapMarkTo = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude))
                let destPlace = Place(category: "Route", placemark: mapMarkTo, name: destination.name)
                request.destination = MKMapItem(placemark: destPlace.placemark)
            }
            else {
                request.destination = MKMapItem.forCurrentLocation()
            }
        }
        
        
        
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard (error == nil) else {print(error!.localizedDescription); return}
            
            if let route = response?.routes.first {
                self.route = route
            }
        }
    }
    
    func getETA(route:MKRoute) -> String{
        let currentDate = Date()
        let ETA = currentDate + route.expectedTravelTime
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: ETA)
        
    }
}
