//
//  CountryTableCell.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit

class CountryCell: UITableViewCell {
    
    var flag: UILabel!
    var name: UILabel!
    var population: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Initialize views
        flag = UILabel("", .white, .systemFont(ofSize: 64))
        name = UILabel("Name", .darkText, .systemFont(ofSize: 22, weight: .medium))
        population = UILabel("Loading population...", .darkGray, .systemFont(ofSize: 17))
        
        let container = UIView()
        container.add().vertical(0).view(name).gap(4).view(population).end(0)
        container.constrain(type: .horizontalFill, name, population)
        
        contentView.add().horizontal(16).view(flag, 60).gap(12).view(container).end(16)
        contentView.add().vertical(16).view(flag, 60).end(">=16")
        contentView.constrain(type: .verticalCenter, container)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

