//
//  UILabel+Extensions.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit

extension UILabel {
    convenience init(_ text: String, _ color: UIColor?, _ font: UIFont?) {
        self.init()
        self.text = text
        self.font = UIFont.systemFont(ofSize: 12)
        if color != nil {
            self.textColor = color!
        }
        if font != nil {
            self.font = font
        }
    }
}
