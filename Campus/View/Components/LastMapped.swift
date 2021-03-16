//
//  LastMapped.swift
//  Campus
//
//  Created by Nikolas Collina on 10/14/20.
//

import SwiftUI

struct LastMapped: View {
    var lastMapped : Place
    @EnvironmentObject var locationsManager : LocationsManager
    let screenSize = UIScreen.main.bounds
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: ViewConstants.cornerRadius).frame(width: (screenSize.width * 0.95) , height: ViewConstants.buttonHeight).foregroundColor(.blue)
            HStack{
                Text(lastMapped.placeName).foregroundColor(.white)
                Button(action: {locationsManager.provideDirections(to: nil, from: nil, place: lastMapped)} ) {
                    Image(systemName: "arrow.triangle.turn.up.right.diamond").foregroundColor(.white)
                }
            }
        }
    }
}

struct LastMapped_Previews: PreviewProvider {
    static let lastMapped = Place.empty
    static var previews: some View {
        LastMapped(lastMapped: lastMapped)
    }
}
