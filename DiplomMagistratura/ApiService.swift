//
//  APIServices.swift
//  DiplomMagistratura
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    func fetchFeedForUrlString(urlString: String, complection: @escaping ([Film]) -> ()) {
        
        let url = URL(string: urlString)!
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var films = [Film]()
  
                let film = Film()
                film.id = json["id"].stringValue
                film.title = json["name_ru"].stringValue
                film.premier = json["premier_rus"].stringValue
                film.year = json["year"].stringValue
                
                film.country = json["country"].stringValue
                film.genres = json["genre"].stringValue
                film.studio = json["studio"].stringValue
                film.trailer = json["trailer"].stringValue
                
                film.bigPoster = json["poster_film_big"].stringValue
                film.smallPoster = json["poster_film_small"].stringValue
                
                film.actors = json["creators"]["actor"].arrayValue.map({$0["name_person_ru"].stringValue})
                film.producers = json["creators"]["producer"].arrayValue.map({$0["name_person_ru"].stringValue})
                film.writers = json["creators"]["writer"].arrayValue.map({$0["name_person_ru"].stringValue})
                film.operators = json["creators"]["operator"].arrayValue.map({$0["name_person_ru"].stringValue})
                film.screens = json["screen_film"].arrayValue.map({$0["preview"].stringValue})
                
                let string = json["description"].stringValue
                if (string.contains("<br />") || string.contains("<br/>") || string.contains("<br>") || string.contains("<br >")) {
                    let substring = string.replacingOccurrences(of: "<br />", with: "")
                    let str = substring.replacingOccurrences(of: "<br>", with: "")
                    let str2 = str.replacingOccurrences(of: "<br >", with: "")
                    let finalString = str2.replacingOccurrences(of: "<br/>", with: "")
                    film.story = finalString
                } else {
                    film.story = json["description"].stringValue
                }
                films.append(film)
                
                print("JSON: \(json)")
                print("============================")
                
                //  print("Images: \(self.imagesArray.description)")
                //  print("---------")
                
                // print("Description: \(json["description"].stringValue)")
                
                
                DispatchQueue.main.async {
                    complection(films)
                }
                
                
                //print("Trailer: \(json["trailer"].stringValue)")
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
 
    
    func fetchTodayFilms(complection: @escaping ([Film]) -> ()) {
        
        let urlString = "http://getmovie.cc/api/kinopoisk.json?id=843272&token=037313259a17be837be3bd04a51bf678"
        fetchFeedForUrlString(urlString: urlString) { (films) in
            complection(films)
        }
    }
    
    func fetchTomorrowFilms(complection: @escaping ([Film]) -> ()) {
        
        let urlString = "http://getmovie.cc/api/kinopoisk.json?id=709487&token=037313259a17be837be3bd04a51bf678"
        fetchFeedForUrlString(urlString: urlString) { (films) in
            complection(films)
        }
    }
    
    func fetchAfterTomorrowFilms(complection: @escaping ([Film]) -> ()) {
        
        let urlString = "http://getmovie.cc/api/kinopoisk.json?id=709487&token=037313259a17be837be3bd04a51bf678"
        fetchFeedForUrlString(urlString: urlString) { (films) in
            complection(films)
        }
    }
    
    func fetchSoonFilms(complection: @escaping ([Film]) -> ()) {
        
        let urlString = "http://getmovie.cc/api/kinopoisk.json?id=1041705&token=037313259a17be837be3bd04a51bf678"
        fetchFeedForUrlString(urlString: urlString) { (films) in
            complection(films)
        }
    }
}
