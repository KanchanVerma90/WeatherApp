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
        let currentTempratureStr = convertTemptoString(tempC: foreCastData.current.temp_c, tempF: foreCastData.current.temp_f)
        let maxTempratureStr = convertTemptoString(tempC: foreCastData.forecast.forecastday.first?.day.maxtemp_c ?? 27.0, tempF: foreCastData.forecast.forecastday.first?.day.maxtemp_f ?? 0.0)
        let minTempratureStr = convertTemptoString(tempC: foreCastData.forecast.forecastday.first?.day.mintemp_c ?? 27.0, tempF: foreCastData.forecast.forecastday.first?.day.mintemp_f ?? 0.0)
        return (currentTempratureStr,maxTempratureStr,minTempratureStr)
    }
    
    func arrayofForecasts() -> [ForecastDay] {
        return foreCastData.forecast.forecastday
    }
    
    func convertTemptoString(tempC:Double, tempF:Double) -> String {
        let measureFormatter1 = MeasurementFormatter()
        let measureFormatter2 = MeasurementFormatter()
        let measurementC = Measurement(value: tempC, unit: UnitTemperature.celsius)
        let measurementF = Measurement(value: tempF, unit: UnitTemperature.fahrenheit)
        var output = measureFormatter1.string(from: measurementC) + "/" + measureFormatter2.string(from: measurementF)
        return output
    }
    
    func getCityName() -> String {
        return foreCastData.location.name
    }
    
    func getWeatherCondition() -> String {
        return foreCastData.current.condition.text
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

