//
//  SearchCityModel.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 03/10/24.
//

import Foundation

class SearchCityModel {
    
    var baseModel: CityListModel?
    
    func addCityToList(city: LocationSearch) {
        var existingRecord = baseModel?.getCities()  ?? []
        existingRecord.append(city)
        baseModel?.saveCitiesToPlist(cities: existingRecord)
        
    }
}
