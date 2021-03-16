//
//  DirectionsButton.swift
//  Campus
//
//  Created by Nikolas Collina on 10/15/20.
//

import SwiftUI

struct DirectionsButton: View {
    
    @EnvironmentObject var locationsManager : LocationsManager
    @State private  var isShowingPreference = false
    
    var body: some View {
        Button(action: { self.isShowingPreference.toggle() }) {
            Image(systemName: "arrow.triangle.turn.up.right.diamond")
        }.sheet(isPresented: $isShowingPreference) {
            DirectionsSelection(isShowingPreferences: $isShowingPreference)
        }
    }
}
//struct DirectionsButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsButton()
//    }
//}
