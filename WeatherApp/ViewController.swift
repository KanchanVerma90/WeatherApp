//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 30/09/24.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var citiesList: UITableView!
    let weatherService = Network()
    let dataModel = CityListModel()
    var cities: [LocationSearch]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uiComponents()
        dataComponents()
    }

    @IBAction func addBtnClicked(_ sender: Any) {
        if (cities?.count ?? 0) < 20 {
            performSegue(withIdentifier: "ShowSearchScreen", sender: self)
        } else {
            self.showAlert(message: "Maximum number of cities reached.") {
                
            }
        }
    }
    
    func uiComponents() {
        self.navigationController?.title = "List of cities"
        let nib = UINib(nibName: "WeatherSummary", bundle: nil)
        citiesList.register(nib, forCellReuseIdentifier: "WeatherSummary")
        citiesList.dataSource = self
        citiesList.delegate = self
        citiesList.estimatedRowHeight = 80
        citiesList.rowHeight = UITableView.automaticDimension
        citiesList.separatorColor = .clear
    }
    func dataComponents() {
        cities?.removeAll()
        cities = dataModel.getCities()
    }
    override func viewWillAppear(_ animated: Bool) {
        if !(cities?.isEmpty ?? true) {
            dataComponents()
            citiesList.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummary", for: indexPath)
       
        if let details = cities?[indexPath.row] as? LocationSearch {
            (cell as? WeatherSummary)?.updateValues(with: details)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          self.dataModel.removeEntryFromArrayInPlist(key: "id", value: String(self.cities?[indexPath.row].id ?? 0))
        self.cities?.remove(at: indexPath.row)
        self.citiesList.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = cities?[indexPath.row ] as? LocationSearch {
            let cityQuery = city.name + "," + city.region + "," + city.country
            self.activityIndicator.startAnimating()
            weatherService.getForecast(cityName: cityQuery, days: 5) { res, err in
                self.activityIndicator.stopAnimating()
               
                if let result = res {
                    let model = WeatherDetailModel()
                    model.foreCastData = result
                    if let detailViewController = self.mainstoryboard.instantiateViewController(withIdentifier: "WeatherDetail") as? WeatherDetail {
                        detailViewController.model = model
                        self.navigationController?.pushViewController(detailViewController, animated: true)
                            }
                } else {
                    self.showAlert(message: "Something went wrong") {}
                }
            }
        }
    }
    
}
