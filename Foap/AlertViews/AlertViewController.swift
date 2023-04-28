//
//  AlertViewController.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit

class AlertViewController: UIViewController {
    
    var messageView: UIView!
    var messageHeader: UILabel!
    var messageBody: UILabel!
    var icon: UIImageView!
    
    var safeAreaInset: UIEdgeInsets? {
        get {
            let delegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
            return delegate.window?.safeAreaInsets
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
        
        // Initialize message container
        messageView = UIView()
        messageView.backgroundColor = .black
        messageView.clipsToBounds = true
        messageView.layer.cornerRadius = 32
        messageView.alpha = 0.2
        
        // Initialize message icon, header & body
        messageHeader = UILabel("", .lightText, .systemFont(ofSize: 10, weight: .semibold))
        messageBody = UILabel("", .white, .systemFont(ofSize: 14))
        icon = UIImageView()
        
        view.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Construct the UI
        let container = UIView()
        container.add().vertical(4).view(messageHeader).gap(4).view(messageBody).end(">=0")
        container.constrain(type: .horizontalFill, messageHeader, messageBody)
        //
        messageView.add().horizontal(16).view(icon, 40).gap(16).view(container).end(24)
        messageView.add().vertical(">=0").view(icon, 38).end(">=0")
        messageView.constrain(type: .verticalCenter, icon, container)
        
        view.add().vertical(-64).view(messageView, 64).end(">=0")
        view.constrain(type: .horizontalCenter, messageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for c in view.constraints where (c.firstItem as? UIView) == messageView && c.firstAttribute == .top {
            c.constant = safeAreaInset!.top + 8
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
            self?.messageView.alpha = 1
        }
    }
    
    func prepareToDismiss() {
        for c in view.constraints where (c.firstItem as? UIView) == messageView && c.firstAttribute == .top {
            c.constant = -64
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
            self?.messageView.alpha = 0.2
        }
    }
}
