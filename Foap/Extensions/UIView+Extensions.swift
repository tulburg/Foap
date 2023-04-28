//
//  UIView+Extensions.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit


extension UIView {
    
    func addConstraints(format: String, views: UIView...) {
        addConstraints(format: format, views: views)
    }
    
    func addConstraints(format: String, views: [UIView]) {
        var viewDict = [String: Any]()
        for(index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewDict[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
    }
    
    func constrain(type: ConstraintType, _ views: UIView..., margin: Float = 0) {
        switch type {
        case .horizontalFill:
            for view in views {
                addConstraints(format: "H:|-\(margin)-[v0]-\(margin)-|", views: view)
            }
        case .verticalFill:
            for view in views {
                addConstraints(format: "V:|-\(margin)-[v0]-\(margin)-|", views: view)
            }
        case .verticalCenter:
            for view in views {
                addConstraints(format: "V:|-(>=\(margin))-[v0]-(>=\(margin))-|", views: view)
                view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            }
        case .horizontalCenter:
            for view in views {
                addConstraints(format: "H:|-(>=\(margin))-[v0]-(>=\(margin))-|", views: view)
                view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            }
        }
    }
    
    func add() -> ConstrainChain {
        return ConstrainChain(self)
    }
    
    func showIndicator(size: UIActivityIndicatorView.Style, color: UIColor, background: UIColor) {
        let loadIndicator = UIActivityIndicatorView()
        loadIndicator.style = size
        loadIndicator.color = color
        
        let wrapper = UIView()
        wrapper.tag = 0x77234
        wrapper.backgroundColor = background
        wrapper.addSubview(loadIndicator)
        wrapper.constrain(type: .verticalCenter, loadIndicator)
        wrapper.constrain(type: .horizontalCenter, loadIndicator)
        wrapper.isUserInteractionEnabled = true
        wrapper.addGestureRecognizer(UITapGestureRecognizer())
        wrapper.layer.cornerRadius = layer.cornerRadius
        
        addSubview(wrapper)
        add().vertical(0).view(wrapper).end(0)
        add().horizontal(0).view(wrapper).end(0)
        loadIndicator.startAnimating()
    }
    
    func showIndicator(size: UIActivityIndicatorView.Style, color: UIColor) {
        showIndicator(size: size, color: color, background: UIColor(hex: 0xFFFFFF).withAlphaComponent(size == .large ? 0.6 : 0.9))
    }
    
    func hideIndicator() {
        for v: UIView in subviews {
            if v.tag == 0x77234 {
                v.removeFromSuperview()
            }
        }
    }
    
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func scale(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scale(by: scale)
        }
    }
    
    func debugLines(color: UIColor?) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color?.cgColor
    }
    func debugLines() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func getImage(scale: CGFloat? = nil) -> UIImage? {
        let bounds = self.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 3.0)
        if let context = UIGraphicsGetCurrentContext()  {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
}

