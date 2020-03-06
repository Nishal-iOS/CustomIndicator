//
//  AppHud.swift
//  CustomIndicatorDemo
//
//  Created by Khushbu Mehta on 06/03/20.
//  Copyright © 2020 Khushbu Mehta. All rights reserved.
//

import Foundation
import UIKit

public class AppHUD {
 
    static let shared: AppHUD = AppHUD()
    
    /// Variables
    let _appDelegate = UIApplication.shared.delegate as! AppDelegate
    var customIndicator : ActivityIndicator?
}

//MARK:- Activity Indicator
extension AppHUD {
    
    func showCentralSpinner(userInteractionEnabled: Bool = false, message: String = "", inView: UIView? = nil, viewController: UIViewController) {
        if let _ = customIndicator{
            customIndicator?.hide()
        }
        viewController.view.isUserInteractionEnabled = userInteractionEnabled
        customIndicator = ActivityIndicator.intance(message)
        if let customHud = customIndicator{
            if let view = inView {
                view.addSubview(customHud)
            } else {
                _appDelegate.window?.addSubview(customHud)
            }
        }
        customIndicator?.show(message)
    }
    
    func hideCentralSpinner(viewController: UIViewController) {
        viewController.view.isUserInteractionEnabled = true
        customIndicator?.hide()
    }
}
