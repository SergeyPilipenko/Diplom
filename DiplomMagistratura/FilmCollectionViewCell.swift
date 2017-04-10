//
//  FilmCollectionViewCell.swift
//  DiplomMagistratura
//
//  Created by Admin on 18.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }

}

class FilmCollectionViewCell: BaseCell {
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "843789")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.layer.cornerRadius = 22
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UILabel = {
        let textView = UILabel()
        //extView.isEditable = false
        //textView.isScrollEnabled = true
        textView.textColor = UIColor.lightGray
        textView.textAlignment = .center
        textView.numberOfLines = 0
        textView.font = textView.font.withSize(11)
       
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
       // addSubview(ratingLabel)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
    
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        //addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, ratingLabel, separatorView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-68-[v1(1)]|", views: thumbnailImageView, separatorView)
       // addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: ratingLabel)
       addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
       
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .left, multiplier: 1, constant: 0))
        
         addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
      
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}


