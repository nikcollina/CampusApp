//
//  CampusMap.swift
//  Campus
//
//  Created by Nikolas Collina on 10/6/20.
//

import SwiftUI
import MapKit

struct CampusMap: View {
    
    @EnvironmentObject var locationsManager : LocationsManager
    @State var userTrackingMode : MapUserTrackingMode = .follow
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $locationsManager.region, interactionModes: .all, showsUserLocation: locationsManager.showsUserLocation, userTrackingMode: $userTrackingMode, annotationItems: locationsManager.mappedPlaces, annotationContent: annotationsForCategory)
                .navigationBarItems(leading: leadingItems, trailing: trailingItems)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        CenterUser()
                    }
                }
            
            if locationsManager.lastMapped.category != "empty" {
                VStack{
                    Spacer()
                    LastMapped(lastMapped: locationsManager.lastMapped).padding()
                }
            }
            
        }
        
    }
    
    func annotationPins (item:Place) -> some MapAnnotationProtocol {
        MapPin(coordinate: item.coordinate)
    }
    func annotationsForCategory (item:Place) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: item.coordinate) {
            Image(systemName: locationsManager.getAnnotation(place: item)).renderingMode(.template).foregroundColor(.blue)
        }
    }
    
    var trailingItems : some View {
        
        HStack{            
            Picker(selection: $locationsManager.selectedBuilding, label: Image(systemName: "map")) {
                ForEach(locationsManager.buildings.indices, id:\.self) { index in
                    Text(locationsManager.buildings[index].name)
                }
            }.pickerStyle(MenuPickerStyle()).padding()
            NavigationLink(destination: BuildingsListView()){
                Image(systemName: "list.star")
            }
        }
    }
    
    var leadingItems : some View {
        HStack{
            Button(action: {locationsManager.clear()}){
                Image(systemName: "clear")
            }
            DirectionsButton().padding()
        }
    }
    
}

struct CampusMap_Previews: PreviewProvider {
    static var previews: some View {
        CampusMap()
    }
}
