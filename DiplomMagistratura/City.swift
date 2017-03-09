//
//  City.swift
//  DiplomMagistratura
//
//  Created by Admin on 09.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    dynamic var region = ""
    dynamic var city = ""
    
    let cinemas = List<Cinema>()
}
