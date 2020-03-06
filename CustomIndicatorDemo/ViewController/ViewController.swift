//
//  ViewController.swift
//  CustomIndicatorDemo
//
//  Created by Khushbu Mehta on 06/03/20.
//  Copyright © 2020 Khushbu Mehta. All rights reserved.
//

import UIKit

/// View Controller
class ViewController: ParentVC {
    
    /// View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Prepare UI
        self.prepareUI()
    }
}

// MARK: - Private
extension ViewController {
    
    private func prepareUI() {
        
    }
}

// MARK: - IBAction
extension ViewController {
    
    @IBAction func btnShowAction(_ sender: UIButton) {
        AppHUD.shared.showCentralSpinner(userInteractionEnabled: true, viewController: self)
    }
    
    @IBAction func btnHideAction(_ sender: UIButton) {
        AppHUD.shared.hideCentralSpinner(viewController: self)
    }
}
