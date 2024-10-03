//
//  CityListModel.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 02/10/24.
//

import Foundation
 
class CityListModel {
    
    var storedCityList = [LocationSearch]()
    
    func getCities() -> [LocationSearch]? {
        let decoder = PropertyListDecoder()
            
            // Get the URL for the plist file
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Cities.plist")
            
            do {
                let data = try Data(contentsOf: fileURL)
                let users = try decoder.decode([LocationSearch].self, from: data)
                return users
            } catch {
                print("Error loading data: \(error)")
                return nil
            }
    }
    
    func saveCitiesToPlist(cities: [LocationSearch]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(cities)
            
            // Get the URL for the Documents directory
            let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Cities.plist")
            
            // Write the data to the plist file
            try data.write(to: fileURL)
            print("Data saved to \(fileURL)")
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    
}
