//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 03/10/24.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var weathericon: UIImageView!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(fromData: ForecastDay) {
        self.selectionStyle = .none
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var date1 = formatter.date(from: fromData.date)
        formatter.dateFormat = "MMM dd"
        var dateDisplay  = formatter.string(from: date1 ?? Date())
        forecastDate.text = dateDisplay
        
        fromData.day.condition.icon.getWeatherImage { img in
            DispatchQueue.main.async {
                self.weathericon.image = img
            }
        }
        maxTemp.text = convertTemptoString(tempC: fromData.day.maxtemp_c)
        minTemp.text = convertTemptoString(tempC: fromData.day.mintemp_c)
    }
    
    func convertTemptoString(tempC:Double) -> String {
        let measureFormatter1 = MeasurementFormatter()
        let measurementC = Measurement(value: tempC, unit: UnitTemperature.celsius)
        var output = measureFormatter1.string(from: measurementC)
        return output
    }
}
