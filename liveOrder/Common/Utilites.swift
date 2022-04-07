//
//  Utilites.swift
//  liveOrder
//
//  Created by PraveenMac on 25/09/21.
//

import Foundation
import UIKit
import KeychainSwift

var container: UIView = UIView()
var loadingView: UIView = UIView()
var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
var App = UIApplication.shared.delegate as! AppDelegate

public extension UIViewController {
    
    /// Show Avtivity controller when API Call
    func showActivityIndicator(_ uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(white: 1, alpha: 0.5)
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        if #available(iOS 13.0, *) {
            activityIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
        }
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        loadingView.addSubview(activityIndicator)
        loadingView.center = container.center
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    /// Hide ActivityController After API Call
    func hideActivityIndicator(_ uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func popViewController()
    {
        self.navigationController?.popViewController(animated: true)
    }
}


