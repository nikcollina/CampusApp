//
//  UserLocationToggle.swift
//  Campus
//
//  Created by Nikolas Collina on 10/14/20.
//

import SwiftUI

struct CenterUser: View {
    @EnvironmentObject var locationsManager : LocationsManager
    var body: some View {
        
        Button(action: { locationsManager.followingUser.toggle() ; locationsManager.centerUser()}) {
            Image(systemName: locationsManager.followingUser ? "location.circle.fill" : "location.circle")
            
            
        }
    }
}

//struct UserLocationToggle_Previews: PreviewProvider {
//    static var previews: some View {
//        UserLocationToggle()
//    }
//}
