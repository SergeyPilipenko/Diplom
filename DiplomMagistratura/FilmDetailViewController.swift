//
//  FilmDetailViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 05.04.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
import SwiftyJSON

class FilmDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    // MARK: - Constants and variables
    var cinema: Cinema?
    var titlesArray = ["Адрес:", "Сайт:", "Автоответчик:", "Заказ билетов:"]
    var detailDictionary: [Int: String] = Dictionary()
    var imagesArray: [String] = Array()
    var isFavorite = false
    var currentPage = 0
    
    var imageView: UIImageView!
    var pageControl: UIPageControl!
    var tableView : UITableView!
    var navigationView = UIView()
    var favoriteButton : UIButton!
    
    let cellId = "cellId"
    let filmsCellId = "filmCellId"
    
    // MARK: - Support functions
    func setupTableView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        // tableView.allowsSelection = false
        tableView.estimatedRowHeight = 20
        view.addSubview(tableView)
        tableView.register(CinemaDescriptionCell.self, forCellReuseIdentifier: cellId)
        tableView.register(CinemaFilmsCell.self, forCellReuseIdentifier: filmsCellId)
    }
    
    func setupNavigationView(){
        
        // NavigationHeader
        let navibarHeight : CGFloat = navigationController!.navigationBar.bounds.height
        let statusbarHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: navibarHeight + statusbarHeight)
        navigationView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 0.99)
        navigationView.alpha = 0.0
        view.addSubview(navigationView)
        
        // I will add this (navigationbar titlelabel)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: statusbarHeight, width: view.frame.size.width, height: navibarHeight)
        label.text = "kino"
        label.textAlignment = .center
        label.textColor = UIColor.green
        navigationView.addSubview(label)
        
        
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 10, y: 20, width: 44, height: 44)
        backButton.setImage(UIImage(named: "navi_back_btn")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        backButton.tintColor = UIColor.green
        backButton.addTarget(self, action: #selector(CinemaDetailViewController.leftButtonAction), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    
    func setupHeaderView() {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/2+22))
        
        header.backgroundColor = UIColor.lightText
        
        imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/2)
       // imageView.image = UIImage(named: imagesArray[currentPage])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .black
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(FilmDetailViewController.swipeHandler(recognizer:)))
        leftSwipe.direction = .left
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(FilmDetailViewController.swipeHandler(recognizer:)))
        rightSwipe.direction = .right
        rightSwipe.numberOfTouchesRequired = 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(FilmDetailViewController.tapHandler))
        
        imageView.addGestureRecognizer(leftSwipe)
        imageView.addGestureRecognizer(rightSwipe)
        imageView.addGestureRecognizer(tap)
        header.addSubview(imageView)
        
        pageControl = UIPageControl()
        pageControl.frame = CGRect(x: imageView.frame.width / 2 - 10, y: imageView.frame.height - 12, width: 10, height: 5)
        pageControl.numberOfPages = imagesArray.count
        pageControl.currentPage = currentPage
        
        imageView.addSubview(pageControl)
        
        favoriteButton = UIButton(type: .custom)
        favoriteButton.frame = CGRect(x: header.frame.width-64, y: header.frame.height-46, width: 44, height: 44)
        
        favoriteButton.layer.cornerRadius = 22
        favoriteButton.backgroundColor = UIColor.white
        favoriteButton.setTitle("1", for: UIControlState())
        favoriteButton.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        header.addSubview(favoriteButton)
        
        tableView.tableHeaderView  = header
    }
    
    // MARK: - Selector
    func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func swipeHandler(recognizer: UISwipeGestureRecognizer){
            switch recognizer.direction {
                case UISwipeGestureRecognizerDirection.left:
                    if currentPage == imagesArray.count {
                        currentPage = 0
                    } else {
                        currentPage += 1
                    }
                case UISwipeGestureRecognizerDirection.right:
                    if currentPage == 0 {
                        currentPage = imagesArray.count
                    } else {
                    currentPage -= 1
                    }
                default:
                    break
            }
        imageView.image = UIImage(named: imagesArray[currentPage])
           pageControl.currentPage = currentPage
        
    }
    
    func tapHandler(){
       print("tap")
        if currentPage == imagesArray.count {
            let videoURL = URL(string: "https://kp.cdn.yandex.net/843789/kinopoisk.ru-Ghost-in-the-Shell-322151.mp4")
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    
    func addFavorite() {
        isFavorite =  !isFavorite
        favoriteButton.setTitleColor(isFavorite ? UIColor.red : UIColor.lightGray, for: UIControlState())
    }
    
    // MARK: - ViewConfiguration
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
        favoriteButton.setTitleColor(isFavorite ? UIColor.red : UIColor.lightGray, for: UIControlState())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://getmovie.cc/api/kinopoisk.json?id=843789&token=037313259a17be837be3bd04a51bf678")!
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
              self.imagesArray = json["screen_film"].arrayValue.map({$0["preview"].stringValue})
                print("JSON: \(json)")
                
                print(self.imagesArray.description)
                self.pageControl.numberOfPages = self.imagesArray.count
            case .failure(let error):
                print(error)
            }
        }
        
        setupTableView()
        setupHeaderView()
        setupNavigationView()
        
        print(imagesArray.count)
        
    }
    
    
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // NavigationHeader alpha update
        let offset : CGFloat = scrollView.contentOffset.y
        if (offset > 50) {
            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(50) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
            navigationView.alpha = CGFloat(alpha)
            
        } else {
            navigationView.alpha = 0.0;
        }
        
    }
    
    // MARK: - TableView configuration
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return titlesArray.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CinemaDescriptionCell
            cell.titleLabel.text = titlesArray[indexPath.row]
            cell.detaillabel.text = detailDictionary[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: filmsCellId, for: indexPath) as! CinemaFilmsCell
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        } else {
            return (view.frame.height - 16)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
