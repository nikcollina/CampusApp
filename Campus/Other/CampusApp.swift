//
//  CampusApp.swift
//  Campus
//
//  Created by Nikolas Collina on 10/5/20.
//

import SwiftUI

@main
struct CampusApp: App {
    let campusData = BuildingManager()
    let locationsManager = LocationsManager()
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            CampusView().environmentObject(locationsManager).environmentObject(campusData)
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .inactive:
                campusData.saveData()
            default:
                break
            }
        }
    }
}

struct CampusApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
