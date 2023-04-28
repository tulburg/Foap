//
//  DetailViewController.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var flag: UILabel!
    var name: UILabel!
    var population: UILabel!
    var tableView: UITableView!
    var header: UIView!
    var dataSource: [[String: String]] = []
    
    var country: Country!
    var safeAreaInset: UIEdgeInsets? {
        get {
            let delegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
            return delegate.window?.safeAreaInsets
        }
    }
    
    init(country: Country) {
        super.init(nibName: nil, bundle: nil)
        
        // Set the identifier for testing
        view.accessibilityIdentifier = "detailViewController"
        
        self.country = country
        
        // Prepare data source with passed country
        // During testing the data here are not so constant
        // Added some default values
        dataSource.append(["Currency": country.currency ?? ""])
        dataSource.append(["Capital": country.capital ?? ""])
        dataSource.append(["Native": country.native ?? ""])
        dataSource.append(["Code": country.code ?? ""])
        dataSource.append(["Language": country.language ?? ""])
        
        view.backgroundColor = .background
        title = country.name
        
        buildHeaderView()
        buildTableView()
        
        // Arrange UI structure
        view.add().vertical(safeAreaInset!.top + 96).view(header).end(">=0")
        view.add().vertical(safeAreaInset!.top + 96 + 96).view(tableView).end(0)
        view.constrain(type: .horizontalFill, tableView, header)
        
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberFormat(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "en_US")
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number))!
    }
    
    // MARK: - UI Build methods
    
    func buildHeaderView() {
        header = UIView()
        
        // Initialize views
        flag = UILabel(country.flag!, .white, .systemFont(ofSize: 64))
        name = UILabel("Population", .darkText, .systemFont(ofSize: 22, weight: .medium))
        population = UILabel("\(numberFormat(country.population!))", .darkGray, .systemFont(ofSize: 17))
        
        let container = UIView()
        container.add().vertical(0).view(name).gap(4).view(population).end(0)
        container.constrain(type: .horizontalFill, name, population)
        
        header.add().horizontal(16).view(flag, 60).gap(12).view(container).end(16)
        header.add().vertical(16).view(flag, 60).end(16)
        header.add().vertical(16).view(container).end(">=0")
    }
    
    func buildTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = .separator
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.register(DetailCell.self, forCellReuseIdentifier: "detail_cell")
    }
    
    // MARK: - TableView delegates
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail_cell") as? DetailCell
        let item = dataSource[indexPath.row]
        cell?.label.text = item.keys.first
        cell?.value.text = item.values.first
            
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
