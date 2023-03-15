//
//  Users.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import Foundation
import RealmSwift

class Users: Object {
    @objc dynamic var firstName = String()
    @objc dynamic var lastName = String()
    @objc dynamic var email = String()
    @objc dynamic var password = String()
    
}
