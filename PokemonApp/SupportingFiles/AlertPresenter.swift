//
//  AlertPresenter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 17.09.23.
//

import UIKit

final class AlertPresenter {
    static func showAlert(title: String = "Attention", message: String?, on viewController: UIViewController?, dismissAction: ((UIAlertAction) -> Void)? = nil) {
        weak var viewController = viewController
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: dismissAction))
            viewController?.present(alertController, animated: true)
        }
    }
}
