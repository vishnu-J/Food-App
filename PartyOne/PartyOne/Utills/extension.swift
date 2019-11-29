//
//  extension.swift
//  PartyOne
//
//  Created by Vishnu on 27/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UILabel{
    
    func applyBlink() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            self.alpha = 0.2
        }) { (completed) in
            self.alpha = 1.0
        }
    }
    
    func applyStroke(oulineColor: UIColor, foregroundColor: UIColor, width:Float){
        let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor : oulineColor,
        NSAttributedString.Key.foregroundColor : foregroundColor,
        NSAttributedString.Key.strokeWidth : width,
        NSAttributedString.Key.font : font ?? UIFont.systemFontSize
        ] as [NSAttributedString.Key : Any]
        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
    }
    
    func applyUnderline(with style:NSUnderlineStyle) {
        if let textString = text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(   NSAttributedString.Key.underlineStyle,
                                             value: style.rawValue,
                                             range: NSRange(location: 0,
                                                            length: attributedString.length))
            attributedText = attributedString
        }
    }
}
