//
//  MainTabBarVC.swift
//  TradeByShop
//
//  Created by Mikhail on 15.03.2023.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
    }
    
    private func setTabBarAppearance() {
        let positionOnY: CGFloat = 25
        let width = tabBar.bounds.width
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: 20
        )
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.white.cgColor
        
        tabBar.tintColor = UIColor(hexString: "737294")
        tabBar.unselectedItemTintColor = .lightGray
    }
}
