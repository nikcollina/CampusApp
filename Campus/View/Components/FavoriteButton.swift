//
//  FavoriteButton.swift
//  Campus
//
//  Created by Nikolas Collina on 10/8/20.
//

import SwiftUI

struct FavoriteButton: View {
    
    @EnvironmentObject var locationsManager : LocationsManager
    @Binding var isFavorite : Bool
    let building : Building
    
    var body: some View {
        Button(action: {locationsManager.favoriteUpdate(isFavorite: isFavorite, building: building); self.isFavorite.toggle()}) {
            ZStack {
                RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                    .stroke(isFavorite ? Color.green : .red, lineWidth: ViewConstants.strokeWidth)
                    .frame(width: ViewConstants.buttonWidth, height: ViewConstants.buttonHeight)
                Text(isFavorite ? "Remove Favorite" : "Mark as Favorite")
                    .foregroundColor(isFavorite ? .green : .red)
            }
        }
    }
    
}

struct FavoriteButton_Previews: PreviewProvider {
    @State static var captured = false
    static let campusData = BuildingManager()
    static var previews: some View {
        FavoriteButton(isFavorite: $captured, building: campusData.buildings[0])
    }
}
