//
//  DetailCell.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit

class DetailCell: UITableViewCell {
    
    var label: UILabel!
    var value: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Initialize views
        label = UILabel("Label", .darkText, .systemFont(ofSize: 18, weight: .medium))
        value = UILabel("Value", .darkGray, .systemFont(ofSize: 18, weight: .medium))
        
        contentView.add().horizontal(32).view(label).gap(">=0").view(value).end(32)
        contentView.constrain(type: .verticalCenter, label, value, margin: 16)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
