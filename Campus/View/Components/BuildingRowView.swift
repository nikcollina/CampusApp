//
//  BuildingRowView.swift
//  Campus
//
//  Created by Nikolas Collina on 10/8/20.
//

import SwiftUI


struct BuildingRowView: View {
    @EnvironmentObject var locationsManager : LocationsManager

    let building : Building
    let index : Int
    var body: some View {
        HStack{
            Text(building.name)
            Spacer()
            Image(systemName: building.favorite ? "star.fill" : "star")
                .foregroundColor(building.favorite ? .yellow : .gray)
        }
    }
}

struct BuildingRowView_Previews: PreviewProvider {
    static let campusData = BuildingManager()
    static var previews: some View {
        BuildingRowView(building: campusData.buildings[0], index: 0)
    }
}
