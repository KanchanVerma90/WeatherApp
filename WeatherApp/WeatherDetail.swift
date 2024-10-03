//
//  WeatherDetail.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 03/10/24.
//

import UIKit

class WeatherDetail: BaseViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var currentTemprature: UILabel!
    @IBOutlet weak var forecast: UITableView!
    var model: WeatherDetailModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    func updateUI() {
        self.cityName.text = model.getCityName()
        var tempratures = model.getCurrentTempratures()
        minTemp.text = "Min: \(tempratures.2)"
        maxTemp.text = "Max: \(tempratures.1)"
        currentTemprature.text = tempratures.0
        model.getWeatherImage(pathVal: model.foreCastData.current.condition.icon, completion: { img in
            DispatchQueue.main.async {
                self.weatherImage.isHidden = img == nil
                self.weatherImage.image = img
            }
        })
    }

}

extension WeatherDetail: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.foreCastData.forecast.forecastday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
   
    
}
