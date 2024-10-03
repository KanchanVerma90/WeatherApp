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

    func removeEntryFromArrayInPlist(key: String, value: String) {
        // Get the path to the plist file in the Documents directory
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not find document directory.")
            return
        }

        let plistURL = documentDirectory.appendingPathComponent("Cities.plist")

        // Load the plist into a mutable array of dictionaries
        var plistArray: [[String: Any]]?
        if let data = try? Data(contentsOf: plistURL) {
            plistArray = (try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)) as? [[String: Any]]
        }

        // Remove the entry from the array
        if var array = plistArray {
            // Filter the array to remove the dictionary with the specified key-value pair
            array.removeAll { dict in
                 dict[key] as? String == value
            }

            // Save the modified array back to the plist file
            do {
                let data = try PropertyListSerialization.data(fromPropertyList: array, format: .xml, options: 0)
                try data.write(to: plistURL)
                print("Entries with key '\(key)' and value '\(value)' removed successfully.")
            } catch {
                print("Error saving plist: \(error)")
            }
        } else {
            print("Could not load plist.")
        }
    }


    
}
