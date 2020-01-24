//
//  UITextfield+extension.swift
//  reciplease
//
//  Created by Darrieumerlou on 24/01/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
