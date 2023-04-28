//
//  CountryView.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let viewModel = CountryViewModel.shared
    
    // Define UI views
    var tableView: UITableView!
    
    // Table data source
    var countries: [Country]?
    
    var safeAreaInset: UIEdgeInsets? {
        get {
            let delegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
            return delegate.window?.safeAreaInsets
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        title = "Countries"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "arrow.counterclockwise.circle"), style: .done, target: self, action: #selector(refresh))
        
        // Prepare data source
        fetchDataSource()
        
        // Build the UI structure
        buildTableView()
        
        // Prepare UI to wait for data source
        tableView.isHidden = true
        
        // Arrange UI structure
        view.add().vertical(0).view(tableView).end(0)
        view.constrain(type: .horizontalFill, tableView)
        
        view.showIndicator(size: .large, color: .primary)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Build functions
    
    func buildTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = .separator
        tableView.backgroundColor = .background
        tableView.register(CountryCell.self, forCellReuseIdentifier: "country_cell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 84, bottom: 0, right: 16)
    }
    
    // MARK: - Internal functions
    
    @objc func refresh() {
        fetchDataSource(true)
    }
    
    func fetchDataSource(_ fromReloading: Bool = false) {
        viewModel.getCountries { [weak self] error, countries in
            self?.tableView.isHidden = false
            self?.view.hideIndicator()
            guard error == nil else {
                AlertView.show("UNABLE TO CONNECT", body: "Please check connectivity", type: .Error)
                return
            }
            if fromReloading {
                AlertView.show("DATA RELOADED", body: "Reload successful!", type: .Success)
            }
            self?.countries = countries
            self?.tableView.reloadData()
        }
    }
    
    func numberFormat(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "en_US")
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number))!
    }
    
    // MARK: - TableView delegates
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "country_cell") as? CountryCell
        cell?.accessoryView = UIImageView(image: UIImage(named: "arrow")?.withTintColor(.separator))
        cell?.backgroundColor = .background
        let bg = UIView()
        bg.backgroundColor = .separatorLight
        cell?.selectedBackgroundView = bg
        
        if let country = countries?[indexPath.row] {
            cell?.name.text = country.name
            cell?.flag.text = country.flag
            if country.population != nil {
                cell?.population.text = "Population: \(numberFormat(country.population!))"
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries![indexPath.row]
        let detailView = DetailViewController(country: country)
        self.navigationController?.pushViewController(detailView, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if var country = countries?[indexPath.row] {
            guard country.population == nil else { return }
            
            if let population = CountryCacheManager.shared()?.getCountryWithCode(country.code) {
                country.population = Int(truncating: population)
                self.countries?[indexPath.row] = country
                DispatchQueue.main.async { [weak self] in
                    (cell as? CountryCell)?.population.text = "Population: \( self?.numberFormat(Int(truncating: population)) ?? "")"
                }
            }else {
                viewModel.getPopulation(code: country.code!) {  [weak self] error, population in
                    guard error == nil else {
                        AlertView.show("NETWORK ERROR", body: "Unable to fetch population", type: .Error)
                        return
                    }
                    country.population = population
                    self?.countries?[indexPath.row] = country
                    DispatchQueue.main.async { [weak self] in
                        (cell as? CountryCell)?.population.text = "Population: \( self?.numberFormat(population) ?? "")"
                    }
                   
                }
            }
        }
        
    }
}
