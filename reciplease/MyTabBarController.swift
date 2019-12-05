//
//  MyTabBarController.swift
//  reciplease
//
//  Created by Darrieumerlou on 27/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    
   @IBOutlet weak var myTabBar: UITabBar!
   
override func viewDidLoad() {
  super.viewDidLoad()
  setupTabBarSeparators()
  barItemAppearance()
 }
    
    func setupTabBarSeparators() {
        
    let itemWidth = floor(self.myTabBar.frame.size.width / CGFloat(self.myTabBar.items!.count))

        // this is the separator width.  1.5px matches the line at the top of the tab bar
        let separatorWidth: CGFloat = 1.5

        // iterate through the items in the Tab Bar, except the last one
        for i in 0...((self.myTabBar.items?.count)! - 2) {
            // make a new separator at the end of each tab bar item
            let separator = UIView(frame: CGRect(x: itemWidth * CGFloat(i + 1) - CGFloat(separatorWidth / 2), y: 0, width: CGFloat(separatorWidth), height: self.myTabBar.frame.size.height))

            // set the color to light gray (default line color for tab bar)
            separator.backgroundColor = UIColor.lightGray

            self.myTabBar.addSubview(separator)
            
            let topBorder = CALayer()
            
            let borderHeight: CGFloat = 1.5
            
            topBorder.borderWidth = borderHeight
            topBorder.borderColor = UIColor.lightGray.cgColor
            topBorder.frame = CGRect(x: 0, y: -1, width: self.myTabBar.frame.width, height: borderHeight)
            self.myTabBar.layer.addSublayer(topBorder)
            
        }
    }
    func barItemAppearance(){
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 17)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 17)!], for: .selected)
}
}
