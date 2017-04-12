//
//  FeedCell.swift
//  DiplomMagistratura
//
//  Created by Admin on 29.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit
import Alamofire

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: FilmsCollectionViewController?
    var anotherHC: CinemaDetailViewController?
    
    var films: [Film]?
    
    func fetchFilms(){
        ApiService.sharedInstance.fetchTodayFilms { (films:[Film]) in
            self.films = films
            self.collectionView.reloadData()
        }
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        fetchFilms()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of items
     return films?.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilmCollectionViewCell
        
        if let urlString = films?[indexPath.row].bigPoster{
            
            Alamofire.request(URL(string: urlString)!).responseData(completionHandler: { (response) in
                if let data = response.result.value{
                    cell.thumbnailImageView.image = UIImage(data: data)
                }
            })
        } else if let urlString = films?[indexPath.row].smallPoster{
            
            Alamofire.request(URL(string: urlString)!).responseData(completionHandler: { (response) in
                if let data = response.result.value{
                    cell.thumbnailImageView.image = UIImage(data: data)
                }
            })
            
        }
        
        if let title = films?[indexPath.row].title {
            cell.titleLabel.text = title
        }
        
        var detailString: String
        if let country = films?[indexPath.row].country, let year = films?[indexPath.row].year, let genres = films?[indexPath.row].genres{
           detailString = "\(country) \u{00B7} \(year) \u{00B7} \(genres)"
            cell.subtitleTextView.text = detailString
        }
        
        
     return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     let height = (self.frame.width - 16 - 16) * 9 / 16
     return CGSize(width: self.frame.width, height: height + 77)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
     return 0
     }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cv = FilmDetailViewController()
        cv.film = (films?[indexPath.row])!
        homeController?.navigationController?.pushViewController(cv, animated: true)
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset : CGFloat = scrollView.contentOffset.y
        
        UIView.animate(withDuration: 4.0) {
            if (offset > 50) {
                    self.homeController?.navigationController?.setNavigationBarHidden(true, animated: true)
                    self.homeController?.setNeedsFocusUpdate()
            } else {
                self.homeController?.navigationController?.setNavigationBarHidden(false, animated: true)
            }

        }
    }
    
}

class TomorrowFeedCell: FeedCell {
    
    override func fetchFilms(){
        ApiService.sharedInstance.fetchTomorrowFilms { (films:[Film]) in
            self.films = films
            self.collectionView.reloadData()
        }
    }

}

class AfterTomorrowFeedCell: FeedCell {
    
   override func fetchFilms(){
        ApiService.sharedInstance.fetchAfterTomorrowFilms { (films:[Film]) in
            self.films = films
            self.collectionView.reloadData()
        }
    }
    
}

class SoonFeedCell: FeedCell {
    
    override func fetchFilms(){
        ApiService.sharedInstance.fetchSoonFilms { (films:[Film]) in
            self.films = films
            self.collectionView.reloadData()
        }
    }
}
