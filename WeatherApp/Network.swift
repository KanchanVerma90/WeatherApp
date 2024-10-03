//
//  Network.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 01/10/24.
//

import Foundation
import Alamofire


struct ForecastResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tz_id: String
    let localtime: String
}

struct LocationSearch: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let id: Int
    let url: String
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let condition: WeatherCondition
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
}

struct Day: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let avgtemp_c: Double
    let condition: WeatherCondition
}


struct SearchResponse: Codable {
    let locations: [LocationSearch]
}


struct City: Codable {
    let name: String
    let country: String
    // Add other relevant fields as necessary
}

class Network {
    
    enum ApiCallType{
        case get
        case post
        case put
    }
    var headers: [String:Any] = [:]
    var params: [String:Any] = [:]
    
    
    func getForecast(cityName: String, days: Int, completion: @escaping (ForecastResponse?, Error?) -> Void) {
        let apiUrl = Constants.baseUrl+"forecast.json"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        params = [
            "key": Constants.apiKey,
            "q": cityName
        ]
        
        AF.request(apiUrl, parameters: params).validate().responseDecodable(of: ForecastResponse.self) { response in
            switch response.result {
            case .success(_):
                print("\(response)")
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func searchLocation(searchString: String, completion: @escaping ([LocationSearch]?, Error?) -> Void) {
        let apiUrl = Constants.baseUrl+"search.json"
        params = [
            "key": Constants.apiKey,
            "q": searchString
        ]
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
       
        AF.request(apiUrl, parameters: params).validate().responseDecodable(of: [LocationSearch].self) { response in
            switch response.result {
            case .success(_):
                print("\(response)")
                completion(response.value, nil)
            case .failure(let error):
                print("\(response)")
                completion(nil, error)
            }
        }
    }
    
}


