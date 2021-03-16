//
//  DirectionsListView.swift
//  Campus
//
//  Created by Nikolas Collina on 10/15/20.
//

import SwiftUI
import MapKit

struct DirectionsListView: View {
    @Binding var route : MKRoute?
    @Binding var isShowingAll : Bool
    var body: some View {
        List{
            ForEach(route?.steps ?? [], id:\.instructions) {step in
                Text(step.instructions)
            }
        }
    }
}

//struct DirectionsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsListView()
//    }
//}
