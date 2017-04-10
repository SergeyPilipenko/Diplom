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
    var actors: Array<Any>?
    var producers:  Array<Any>?
    var writers:  Array<Any>?
    var operators:  Array<Any>?
    var screens:  Array<Any>?
    
    override var description: String{
        let str = ""
        print("=========")
        print(id)
        print(title)
        print(premier)
        print(year)
        print(country)
        print(genres)
        print(studio)
        print(trailer)
        print(bigPoster)
        print(smallPoster)
        print(story)
        print(actors?.description)
        print(producers?.description)
        print(writers?.description)
        print(operators?.description)
        print(screens?.description)
        print("=========")
        return str
    }
    
}
