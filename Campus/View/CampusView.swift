//
//  ContentView.swift
//  Campus
//
//  Created by Nikolas Collina on 10/5/20.
//

import SwiftUI

struct CampusView: View {
    
    @StateObject var locationsManager = LocationsManager()
    @StateObject var campusData = BuildingManager()
    
    var body: some View {
        NavigationView{
            ZStack{
                CampusMap()
                if locationsManager.route != nil {
                    VStack{
                        DirectionsView(route: $locationsManager.route)
                            .frame(height:ViewConstants.directionsHeight)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Buildings")
            .navigationBarTitleDisplayMode(.inline)
            
            
            
        }.navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(locationsManager)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CampusView()
    }
}
