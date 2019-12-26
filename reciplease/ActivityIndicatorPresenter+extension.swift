//
//  extension ActivityIndicatorPresenter.swift
//  reciplease
//
//  Created by Darrieumerlou on 06/12/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

public extension ActivityIndicatorPresenter where Self: UIViewController {

    func showActivityIndicator() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .large
            loadingIndicator.startAnimating();

            alert.view.addSubview(loadingIndicator)
            self.present(alert, animated: true, completion: nil)
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
