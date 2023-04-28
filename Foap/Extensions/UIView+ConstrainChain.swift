//
//  UIView+ConstrainChain.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit

class ConstrainChain {
    var chain: String = ""
    var host: UIView!
    var viewIndex: Int = 0
    var subviews: [UIView] = []
    init(_ host: UIView) {
        self.host = host
    }
    
    func vertical(_ startMargin: CGFloat) -> ConstrainChain {
        chain += "V:|-(\(startMargin))-"
        return self
    }
    
    func vertical(_ startMargin: String) -> ConstrainChain {
        chain += "V:|-(\(startMargin))-"
        return self
    }
    func horizontal(_ startMargin: CGFloat) -> ConstrainChain {
        chain += "H:|-(\(startMargin))-"
        return self
    }
    
    func horizontal(_ startMargin: String) -> ConstrainChain {
        chain += "H:|-(\(startMargin))-"
        return self
    }
    
    func view(_ subView: UIView) -> ConstrainChain {
        if subviews.firstIndex(of: subView) == nil {
            host.addSubview(subView)
            subviews.append(subView)
        }
        chain += "[v\(viewIndex)]-"
        viewIndex += 1
        return self
    }
    func view(_ subView: UIView, _ size: CGFloat) -> ConstrainChain {
        if subviews.firstIndex(of: subView) == nil {
            host.addSubview(subView)
            subviews.append(subView)
        }
        chain += "[v\(viewIndex)(\(size))]-"
        viewIndex += 1
        return self
    }
    func view(_ subView: UIView, _ size: String) -> ConstrainChain {
        if subviews.firstIndex(of: subView) == nil {
            host.addSubview(subView)
            subviews.append(subView)
        }
        chain += "[v\(viewIndex)(\(size))]-"
        viewIndex += 1
        return self
    }
    func gap(_ margin: CGFloat) -> ConstrainChain {
        chain += "(\(margin))-"
        return self
    }
    func gap(_ margin: String) -> ConstrainChain {
        chain += "(\(margin))-"
        return self
    }
    
    func end(_ margin: CGFloat) {
        chain += "(\(margin))-|"
        host.addConstraints(format: chain, views: subviews)
    }
    func end(_ margin: String) {
        chain += "(\(margin))-|"
        host.addConstraints(format: chain, views: subviews)
    }
}
