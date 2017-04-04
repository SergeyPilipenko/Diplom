//
//  FeedCell.swift
//  DiplomMagistratura
//
//  Created by Admin on 29.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: FilmsCollectionViewController?

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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of items
     return 5
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilmCollectionViewCell
     
     
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
      //  let layout = UICollectionViewFlowLayout()
        //let cv = DetailFilmCollectionViewController(collectionViewLayout: layout)
        //homeController?.navigationController?.pushViewController(cv, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset : CGFloat = scrollView.contentOffset.y
        
        UIView.animate(withDuration: 2.0) {
            if (offset > 50) {
                    self.homeController?.navigationController?.setNavigationBarHidden(true, animated: true)
            } else {
                self.homeController?.navigationController?.setNavigationBarHidden(false, animated: true)
            }

        }
        
    }
}

