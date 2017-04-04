//
//  CustomTableViewCell.swift
//  DiplomMagistratura
//
//  Created by Admin on 05.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  /*  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }*/
    
    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }*/
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    func configureCell(){
        
    }

}

class CinemaDescriptionCell: BaseTableViewCell {

    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Автоответчик:"
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let detaillabel: UILabel = {
        let lb = UILabel()
        lb.text = "8-800-200-3fffhhhffdfsdfgdfgdfsg00"
        lb.textAlignment = .left
        lb.font = UIFont(name: lb.font.fontName, size: 14)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override func configureCell(){
        
        addSubview(titleLabel)
        addSubview(detaillabel)

        addConstraintsWithFormat(format: "H:|-10-[v0(115)]", views: titleLabel)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: titleLabel)
        
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: detaillabel)
        addConstraint(NSLayoutConstraint(item: detaillabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: detaillabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailingMargin, multiplier: 1, constant: 20))
        
    }
}

class CinemaFilmsCell: BaseTableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 48, left: 0, bottom: 0, right: 0)
        cv.scrollIndicatorInsets = UIEdgeInsets(top: 48, left: 0, bottom: 0, right: 0)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.bounces = false
        cv.backgroundColor = .white
        return cv
    }()
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    let colors: [UIColor] = [.green, .black, .purple]
    override func configureCell() {
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "cell")
        
       
        addSubview(menuBar)
        addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        addConstraintsWithFormat(format: "V:|[v0(44)]", views: menuBar)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
        
        //cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // MARK: ScrollView functions
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let target = targetContentOffset.pointee.x / self.frame.width
        let indexPath = IndexPath(item: Int(target), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}
