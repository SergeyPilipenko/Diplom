//
//  Films.swift
//  DiplomMagistratura
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import Foundation

class Film: NSObject {
    var id: String?
    var title: String?
    var premier: String?
    var year: String?
    var country: String?
    var genres: String?
    var studio: String?
    var trailer: String?
    var bigPoster: String?
    var smallPoster: String?
    var story: String?
    var actors: Array<String>?
    var producers:  Array<String>?
    var writers:  Array<String>?
    var operators:  Array<String>?
    var screens:  Array<String>?
    
    
    
    override var description: String{
        let str = ""
        print("=========")
        print(id)
        print(title)
        print(bigPoster)
        print(smallPoster)
        print(trailer)
        print(screens?.description)
        print(country)
        print(year)
        print(premier)
        print(studio)
        print(genres)
        print(producers?.description)
        print(writers?.description)
        print(operators?.description)
        print(actors?.description)
        print(story)
        print("=========")
        return str
    }
    
}
