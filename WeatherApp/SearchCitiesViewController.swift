//
//  SearchCitiesViewController.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 02/10/24.
//

import UIKit

import UIKit

class SearchCitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    var results: [String] = []
    var filteredResults: [String] = []
     
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
        cell.textLabel?.text = isFiltering() ? filteredResults[indexPath.row] : results[indexPath.row]
        return cell
    }

    // MARK: - Filtering

    func isFiltering() -> Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }

    // MARK: - Networking

    func fetchAutocompleteResults(for query: String) {
        network.searchLocation(searchString: query)
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
