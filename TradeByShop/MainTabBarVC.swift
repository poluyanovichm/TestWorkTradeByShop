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
                x: 0, // positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: 20 /// 2
        )
        
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.white.cgColor
        
        tabBar.tintColor = UIColor(hexString: "737294")  // .tabBarItemAccent
        tabBar.unselectedItemTintColor = .lightGray
        
        
//        //tabBar.layer.maskedCorners = CACornerMask(rawValue: 9)
//        tabBar.layer.cornerRadius = 20
//        tabBar.layer.masksToBounds = true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
//        if item.tag == 0 {
//            tabBar.layer.cornerRadius = 20
//            tabBar.layer.masksToBounds = true
//        } else {
//        }
    }
}
