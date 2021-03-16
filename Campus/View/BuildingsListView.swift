//
//  BuildingsListView.swift
//  Campus
//
//  Created by Nikolas Collina on 10/8/20.
//

import SwiftUI

struct BuildingsListView: View {
    @EnvironmentObject var campusData : BuildingManager
    @EnvironmentObject var locationsManager : LocationsManager
    var body: some View {
        List {
            ForEach(locationsManager.buildings.indices, id:\.self) {index in
                
                NavigationLink(destination: BuildingDetailView( building: self.campusData.buildings[index], index: index)) {
                    BuildingRowView(building: self.campusData.buildings[index], index: index)
                }.navigationViewStyle(StackNavigationViewStyle())
                
            }
        }
    }
}

struct BuildingsListView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingsListView()
    }
}
