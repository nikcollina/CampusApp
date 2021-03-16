//
//  CampusData.swift
//  Campus
//
//  Created by Nikolas Collina on 10/6/20.
//

import Foundation
import CoreLocation

struct Building : Codable{
    let latitude : CLLocationDegrees
    let longitude : CLLocationDegrees
    let name : String
    let oppBuildingCode : Int
    let photo : String?
    let yearConstructed : Int?
    var favorite : Bool
    
    enum CodingKeys : String, CodingKey {
        case latitude
        case longitude
        case name
        case oppBuildingCode = "opp_bldg_code"
        case photo
        case yearConstructed = "year_constructed"
        
        case favorite = "favorite"

    }
    
}

typealias Buildings = [Building]


class BuildingManager : ObservableObject {
    
    @Published var  buildings : Buildings
    
    let destinationURL : URL
    
    init() {
        let filename = "buildings"
        let mainBundle = Bundle.main
        let bundleURL = mainBundle.url(forResource: filename, withExtension: "json")!
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path)
        
        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            buildings = try decoder.decode(Buildings.self, from: data)

        }
        catch {
            print("Error info: \(error)")
            buildings = []
        }
        buildings = buildings.sorted(by: {$0.name < $1.name})
        
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(buildings)
            try data.write(to: self.destinationURL)
        } catch {
            print("Error writing: \(error)")
        }
    }
    
}
