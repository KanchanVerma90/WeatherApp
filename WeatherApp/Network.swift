//
//  Network.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 01/10/24.
//

import Foundation
import Alamofire

class Network {
    
    enum ApiCallType{
        case get
        case post
        case put
    }
    var headers: [String:Any] = [:]
    var params: [String:Any] = [:]
    
    
    func getForecast(cityName: String, days: Int) {
        let apiUrl = Constants.baseUrl+"forecast.json?q=\(cityName)&days=\(days)&key=\(Constants.apiKey)"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        AF.request(apiUrl).responseDecodable(of: ForecastResponse.self, decoder: decoder){ response in
            print("\(response)")
        }

    }
    
    func searchLocation(searchString: String, completion: @escaping (Result<[Location], Error>) -> Void) {
        let apiUrl = Constants.baseUrl+"search.json?q=\(searchString)&key=\(Constants.apiKey)"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
       // AF.request(apiUrl).responseDecodable(of: SearchResponse.self, decoder: decoder){ response in
        //    print("\(response.error)")
      //
      //  }
        let request = NSMutableURLRequest(url: URL(string: apiUrl)!)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            self.parseData(data: data!)
        }
        task.resume()
    }
    
    func parseData(data: Data) {
        do{
            if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                do {
                            let users = try JSONDecoder().decode(LocationSearch.self, from: data)
                    print("result ]\(users)")
                           // completion(users, nil)
                        } catch {
                           // completion(nil, error)
                        }
            }} catch {
            print(error)
        }
    }
}



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
