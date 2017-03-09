//
//  Cinema.swift
//  DiplomMagistratura
//
//  Created by Admin on 09.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
// Current version Realm: 1

import Foundation
import RealmSwift

class Cinema: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }

    dynamic var name = ""
    dynamic var isFavourite = false
    dynamic var adress = ""
    dynamic var autoresponderPhone = ""
    dynamic var reservedPhone = ""
    dynamic var site = ""
    dynamic var carTime = 0
    dynamic var masstransitTime = 0
    dynamic var pedestrianTime = 0
}
