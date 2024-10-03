//
//  SearchCitiesViewController.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 02/10/24.
//

import UIKit

import UIKit

class SearchCitiesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    var results: [String] = []
    var filteredResults: [LocationSearch] = []
     var searchModel = SearchCityModel()
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    @IBOutlet weak var errorView: UIView!
    let network = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a city"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredResults.count : results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let res = (filteredResults[indexPath.row])
        cell.textLabel?.text = isFiltering() ? (res.name + "," + res.region + "," +  res.country) : results[indexPath.row]
        return cell
    }

    // MARK: - Filtering

    func isFiltering() -> Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }

    // MARK: - Networking

    func fetchAutocompleteResults(for query: String) {
        self.activityIndicator.startAnimating()
        self.network.searchLocation(searchString: query) { cities, error in
            self.activityIndicator.stopAnimating()
            if let autocompleteResult = cities {
                self.filteredResults.removeAll()
                for res in autocompleteResult {
                    self.filteredResults.append(res)
                }
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.errorView.isHidden = true
            } else {
                self.tableView.isHidden = true
                self.errorView.isHidden = false
            }
           
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = filteredResults[indexPath.row]
        let baseModel = ((self.navigationController?.viewControllers.first(where: {$0.isKind(of: ViewController.self)})) as! ViewController).dataModel
        searchModel.baseModel = baseModel
        searchModel.addCityToList(city: city)
        self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty && searchText.count > 2 {
            fetchAutocompleteResults(for: searchText)
        } else {
            filteredResults.removeAll()
            tableView.reloadData()
        }
    }
}
