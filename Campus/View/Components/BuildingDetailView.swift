//
//  BuildingDetailView.swift
//  Campus
//
//  Created by Nikolas Collina on 10/8/20.
//

import SwiftUI

struct BuildingDetailView: View {
    @EnvironmentObject var campusData : BuildingManager
    @EnvironmentObject var locationsManager : LocationsManager

    
    var building : Building
    let index : Int
    var body: some View {
        ScrollView{
            VStack {
                Image(building.photo ?? "crest")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ViewConstants.imageSize, height: ViewConstants.imageSize)
                
                VStack (alignment: .center){
                    
                    Text(building.name).font(.headline)
                    HStack{
                        VStack{
                            if building.yearConstructed != nil {
                                Text(String(format: "Year Constructed: %04d", building.yearConstructed!))
                            }
                            
                            Text(String(format:"Building Code: %06d", building.oppBuildingCode))
                        }
                        Spacer()
                        FavoriteButton(isFavorite: $campusData.buildings[index].favorite, building: building)
                    }
                    
                }
            }.padding()
        }
    }
}

struct BuildingDetailView_Previews: PreviewProvider {
    static let campusData = BuildingManager()
    static var previews: some View {
        BuildingDetailView(building: campusData.buildings[0], index: 0)
    }
}
