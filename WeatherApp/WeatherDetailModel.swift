//
//  WeatherDetailModel.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 03/10/24.
//

import Foundation
import UIKit

class WeatherDetailModel {
    var foreCastData: ForecastResponse!
    
    func getCurrentTempratures() -> (String, String, String) {
        let currentTempratureStr = convertTemptoString(tempC: foreCastData.current.temp_c)
        let maxTempratureStr = convertTemptoString(tempC: foreCastData.forecast.forecastday.first?.day.maxtemp_c ?? 27.0)
        let minTempratureStr = convertTemptoString(tempC: foreCastData.forecast.forecastday.first?.day.mintemp_c ?? 27.00)
        return (currentTempratureStr,maxTempratureStr,minTempratureStr)
    }
    
    func arrayofForecasts() -> [ForecastDay] {
        return foreCastData.forecast.forecastday
    }
    
    func convertTemptoString(tempC:Double) -> String {
        let measureFormatter1 = MeasurementFormatter()
        let measurementC = Measurement(value: tempC, unit: UnitTemperature.celsius)
        var output = measureFormatter1.string(from: measurementC)
        return output
    }
    
    func getCityName() -> String {
        return foreCastData.location.name
    }
    
    func getWeatherCondition() -> String {
        let windSpeed = String(foreCastData.current.wind_kph) + "kmph " + foreCastData.current.wind_dir
        return foreCastData.current.condition.text + " with wind at \(windSpeed)"
    }
    
    func getWeatherImage(pathVal: String, completion: @escaping (UIImage?) -> Void)  {
        if let url = URL(string: "https:\(pathVal)") {
            DispatchQueue.global(priority: .background).async {
                    let data = try? Data(contentsOf: url)
                    var imageData = (data != nil ? UIImage(data: data!) : nil)
                completion(imageData )
            }
                }
    }
}

