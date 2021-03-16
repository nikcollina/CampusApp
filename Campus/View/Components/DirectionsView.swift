//
//  DirectionsView.swift
//  Campus
//
//  Created by Nikolas Collina on 10/14/20.
//

import SwiftUI
import MapKit

struct DirectionsView: View {
    
    @Binding var route : MKRoute?
    @EnvironmentObject var locationsManager : LocationsManager
    @State private  var isShowingAll = false
    
    var body: some View {
        VStack{
            TabView {
                ForEach(route?.steps ?? [], id:\.instructions) {step in
                    VStack{
                        HStack{
                            Text(step.instructions).foregroundColor(.white)
                            Button(action: { self.isShowingAll.toggle() }) {
                                Image(systemName: "list.dash").foregroundColor(.white)
                            }.sheet(isPresented: $isShowingAll) {
                                DirectionsListView(route: $route, isShowingAll: $isShowingAll)
                            }
                        }
                        if route != nil{
                                Text("ETA: \(locationsManager.getETA(route: route!))").foregroundColor(.white)
                        }
                    }
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .background(Color.blue)
        }
    }
}

//struct DirectionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsView()
//    }
//}
