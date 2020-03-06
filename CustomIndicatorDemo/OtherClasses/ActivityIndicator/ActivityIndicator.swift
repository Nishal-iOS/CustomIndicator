//
//  ActivityIndicator.swift
//  SocialApp
//
//  Created by Yudiz Solutions Pvt Ltd on 13/08/18.
//  Copyright © 2018 Yudiz Solutions Pvt Ltd. All rights reserved.
//

import UIKit

// MARK: - EXTENTION
extension String {
    func requiredHeight(width: CGFloat, font: UIFont,numberOfLines:Int = 0,lineBreakMode:NSLineBreakMode = .byWordWrapping) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
    
    func requiredWidth(font: UIFont) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 1
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.width
    }
}

/// ScreenSize Class
enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let frame        = UIScreen.main.bounds
    static let maxLength    = max(width, height)
    static let minLength    = min(width, height)
    static let size         = UIScreen.main.bounds.size
}

class ActivityIndicator: UIView {
    
    // MARK: Outlets
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var imgActv: UIImageView!
    @IBOutlet var containerView: UIView!
    
    /// Variables
    //    let image = UIImage(named: "loading")
    var isAnimating : Bool = false
    var hidesWhenStopped : Bool = true
    
    // MARK - Variables
    lazy var animationLayer : CALayer = {
        return self.imgActv.layer
    }()
    
    // MARK: Init
    class func intance(_ message: String = "") -> ActivityIndicator {
        let view = Bundle.main.loadNibNamed("ActivityIndicator", owner: nil, options: nil)![0] as! ActivityIndicator
        view.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        view.addRotation(forLayer: view.animationLayer)
        view.pause(layer: view.animationLayer)
        view.lblMessage.text = message
        view.isUserInteractionEnabled = false
        view.layoutIfNeeded()
        return view
    }
    
    func show(_ message: String = ""){
        
        self.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        self.lblMessage.text = message
        self.startAnimating()
        self.layoutIfNeeded()
    }
    
    func hide(){
        self.stopAnimating()
        self.removeFromSuperview()
    }
    
    func msgWidth(message msg:String) -> CGFloat{
        let width = msg.requiredWidth(font: UIFont.systemFont(ofSize: 16 /* ScreenSize.widthRatio*/))
        return min(ScreenSize.height - 80, width)
    }
    
    func msgHeight(message msg:String) -> CGFloat{
        let width = msgWidth(message: msg)
        let height = msg.requiredHeight(width: width, font: UIFont.systemFont(ofSize: 16 /* ScreenSize.widthRatio*/))
        return max(80, height + height + 28)
    }
}

// MARK - Func
extension ActivityIndicator {
    
    func addRotation(forLayer layer : CALayer) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotation.duration = 0.4
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = CAMediaTimingFillMode.forwards
        rotation.fromValue = NSNumber(value: 0.0)
        rotation.toValue = NSNumber(value: 3.14 * 2.0)
        layer.add(rotation, forKey: "rotate")
    }
    
    func pause(layer : CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        isAnimating = false
    }
    
    func resume(layer : CALayer) {
        let pausedTime : CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        isAnimating = true
    }
    
    func startAnimating () {
        if isAnimating {
            return
        }
        if hidesWhenStopped {
            self.isHidden = false
        }
        resume(layer: animationLayer)
    }
    
    func stopAnimating () {
        if hidesWhenStopped {
            self.isHidden = true
        }
        pause(layer: animationLayer)
    }
}
