//
//  DirectionsSelection.swift
//  Campus
//
//  Created by Nikolas Collina on 10/15/20.
//

import SwiftUI

struct DirectionsSelection: View {
    @Binding var isShowingPreferences : Bool
    @EnvironmentObject var locationsManager : LocationsManager
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Direction Type")) {
                    Picker(selection: $locationsManager.currentDirectionType, label: Text("Select Direction Type")) {
                        ForEach(locationsManager.directionTypes.indices, id:\.self) { index in
                            Text(locationsManager.directionTypes[index])
                        }
                    }
                }
                
                Section(header: Text("Start Location")) {
                    Picker(selection: $locationsManager.startBuilding, label: Text("Select Start Location")) {
                        ForEach(locationsManager.buildings.indices, id:\.self) { index in
                            Text(locationsManager.buildings[index].name)
                        }
                    }
                }.disabled(locationsManager.currentDirectionType == 0)
                
                Section(header: Text("End Location")) {
                    Picker(selection: $locationsManager.endBuilding, label: Text("Select End Location")) {
                        ForEach(locationsManager.buildings.indices, id:\.self) { index in
                            Text(locationsManager.buildings[index].name)
                        }
                    }
                }.disabled(locationsManager.currentDirectionType == 2)
            }
        }
        Button(action: {locationsManager.provideDirections(to: locationsManager.endBuilding, from: locationsManager.startBuilding, place: nil)}) {
            Text("Get Directions").padding()
        }
    }
}

//struct DirectionsSelection_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsSelection()
//    }
//}
