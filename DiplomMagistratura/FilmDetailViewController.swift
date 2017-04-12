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
import Foundation

class FilmDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    // MARK: - Constants and variables
    var film = Film()
    var cinema: Cinema?
    var titlesArray = ["Страна:", "Год:", "Премьера РФ:", "Студия:", "Жанр:", "Продюссер:", "Сценарист:", "Оператор:", "В ролях:", "Описание:"]
    var detailArray: [String] = Array()
    var imagesArray: [String] = Array()
    var isFavorite = false
    var currentPage = 0
    
    var imageView: UIImageView!
    var pageControl: UIPageControl!
    var tableView : UITableView!
    var navigationView = UIView()
    var favoriteButton : UIButton!
    var isExpandedCell = false
    var isExpandedCellIndexPath: IndexPath?
    
    
    let cellId = "cellId"
    let filmsCellId = "filmCellId"
    let filmDescrCellId = "filmDescrCellId"
    
    // MARK: - Support functions
    
    func setupTableView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.estimatedRowHeight = 20
        view.addSubview(tableView)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: cellId)
        tableView.register(CinemaFilmsCell.self, forCellReuseIdentifier: filmsCellId)
        tableView.register(FilmDescriptionCell.self, forCellReuseIdentifier: filmDescrCellId)
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
        label.text = film.title
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
        
         let urlString = imagesArray[currentPage]
        Alamofire.request(URL(string: urlString)!).responseData(completionHandler: { (response) in
                if let data = response.result.value{
                   self.imageView.image = UIImage(data: data)
                }
            })

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
        pageControl.frame = CGRect(x:0, y: imageView.frame.height - 12, width: imageView.frame.width - 5, height: 5)
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
                    if currentPage == imagesArray.count - 1 {
                        currentPage = 0
                    } else {
                        currentPage += 1
                    }
                case UISwipeGestureRecognizerDirection.right:
                    if currentPage == 0 {
                        currentPage = imagesArray.count - 1
                    } else {
                    currentPage -= 1
                    }
                default:
                    break
            }
        
        if !imagesArray[currentPage].contains("trailer"){
            let urlString = imagesArray[currentPage]
            Alamofire.request(URL(string: urlString)!).responseData(completionHandler: { (response) in
                if let data = response.result.value{
                    self.imageView.image = UIImage(data: data)
                }
            })
        } else{
            imageView.image = UIImage(named: imagesArray[currentPage])
        }
            pageControl.currentPage = currentPage
        
    }
    
    func tapHandler(){
       print("tap")
       if imagesArray[currentPage].contains("trailer") {
            let videoURL = URL(string: film.trailer!)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
        self.present(playerViewController, animated: true){
            playerViewController.player?.play()
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
        
        let objects: (titArr: Array, detArr: Array) = createDictionaryForDetailDescription(titles: titlesArray, strings: film.country, film.year, film.premier, film.studio, film.genres, film.producers, film.writers, film.operators, film.actors, film.story)
        
        titlesArray = objects.titArr
        detailArray = objects.detArr
        
       /* print("=======Titles")
        print(titlesArray.description)
        print("======Titles")
        print(detailArray.description)*/
        
        print(film.description)
        
        
        if titlesArray.contains("Описание:") {
            isExpandedCellIndexPath = IndexPath(row: titlesArray.count - 1, section: 0)
        }
        
        if let screens = film.screens {
         
            if !screens.isEmpty {
            
                for (_, value) in screens.enumerated() {
                    let str: String = value
                    imagesArray.append(str)
                }
            } else {
               imagesArray.append(String(describing: film.bigPoster!))
            }
            
        } else {
            imagesArray.append(String(describing: film.bigPoster!))
        }
        
        if let trailer = film.trailer {
            if !trailer.isEmpty{
                imagesArray.append("trailer")
            }
        }
        
       // print(imagesArray.description)
        //print(film.description)
        
        setupTableView()
        setupHeaderView()
        setupNavigationView()
        
        
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
            if titlesArray[indexPath.row].contains("Описание:"){
                let cell = tableView.dequeueReusableCell(withIdentifier: filmDescrCellId, for: indexPath) as! FilmDescriptionCell
                cell.titleLabel.text = titlesArray[indexPath.row]
                cell.detaillabel.text = detailArray[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DescriptionCell
                cell.titleLabel.text = titlesArray[indexPath.row]
                cell.detaillabel.text = detailArray[indexPath.row]
                return cell
            }
        }
        
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: filmsCellId, for: indexPath) as! CinemaFilmsCell
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if let ip = isExpandedCellIndexPath {
            
            let cell = tableView.cellForRow(at: indexPath) as! FilmDescriptionCell
            if ip == indexPath{
                if isExpandedCell == false {
                isExpandedCell = true
                cell.symbolLabel.text = "\u{02C6}"
            } else {
                isExpandedCell = false
                cell.symbolLabel.text = "\u{02C7}"
            }
        
            }
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0 {
            if let ip = isExpandedCellIndexPath, ip == indexPath{
                    if isExpandedCell {
                        return UITableViewAutomaticDimension
                    } else {
                        return 30
                    }

            }
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
