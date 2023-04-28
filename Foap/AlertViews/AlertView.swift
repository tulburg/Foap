//
//  AlertView.swift
//  Foap
//
//  Created by Tolu Oluwagbemi on 28/04/2023.
//

import UIKit

class AlertView {
    
    // Enum to determine which icon is displayed
    enum AlertType {
        case Error
        case Success
    }
    
    static func show(_ header: String, body: String, type: AlertType = .Success) {
        let sceneDelegate: SceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        if let navigationController = sceneDelegate.window?.rootViewController as? NavigationController {
            
            // Initialize alert view controller
            // Set the required fields
            let vc = AlertViewController()
            vc.messageBody.text = body
            vc.messageHeader.text = header
            if type == .Error {
                let errorImage = UIImage(systemName: "exclamationmark.octagon")
                vc.icon.tintColor = .systemRed
                vc.icon.image = errorImage
            }
            if type == .Success {
                let successImage = UIImage(systemName: "checkmark.circle.fill")
                vc.icon.tintColor = .systemGreen
                vc.icon.image = successImage
            }
            // Set our modal presentation style to no override our internal animation
            vc.modalPresentationStyle = .overCurrentContext
            // Show the view controller
            navigationController.present(vc, animated: false)
            
            // Set time for dismissal
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                vc.prepareToDismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    vc.dismiss(animated: false)
                }
            }
        }
    }
    
    
}
