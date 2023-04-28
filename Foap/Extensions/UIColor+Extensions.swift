//
//  UIColor+Extensions.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import Foundation

extension UIColor {
    
    // converts HEX color code to RGBA
    convenience init(hex: Int) {
        self.init(red: CGFloat((hex >> 16) & 0xff) / 255.0, green: CGFloat((hex >> 8) & 0xff) / 255.0, blue: CGFloat(hex & 0xff) / 255.0, alpha: 1)
    }
    
    static let primary = UIColor(hex: 0x2cd5c4)
    static let background = UIColor(hex: 0xf7f7f7)
    static let backgroundDark = UIColor(hex: 0xe9e9e9)
    static let separatorLight = UIColor(hex: 0xF0F0F0)
    static let separator = UIColor(hex: 0xd8d8d8)
}
