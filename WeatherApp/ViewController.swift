//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 30/09/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var citiesList: UITableView!
    let weatherService = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiComponents()
    }

    @IBAction func addBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "ShowSearchScreen", sender: self)
    }
    
    func uiComponents() {
        let nib = UINib(nibName: "WeatherSummary", bundle: nil)
        citiesList.register(nib, forCellReuseIdentifier: "WeatherSummary")
        citiesList.dataSource = self
        citiesList.delegate = self
        
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummary", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellAt = tableView.cellForRow(at: indexPath)
        weatherService.getForecast(cityName: "London", days: 5)
    }
    
}
