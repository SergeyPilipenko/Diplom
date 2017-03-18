//
//  MapViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 26.02.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit
import RealmSwift

class MapViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    var data: Results<Cinema>!
    //let colors: [UIColor] = [.red, .green, .gray, .darkGray]
    
    // MARK: - IBOUtlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    
   
    // MARK: - Methods
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Realm.Configuration.defaultConfiguration.schemaVersion = 1
       

        

        let realm = try! Realm()
        data = realm.objects(Cinema.self)
        print(data.description)
        
       
          if let path =  Bundle.main.path(forResource: "MapHTMLCode", ofType: "html") {
            print("ok")
            let url = URL(fileURLWithPath: path)
            webView.loadRequest(URLRequest(url: url))
          }else{
            print("not ok")
        }
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }



    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        let cinema: Cinema = data[indexPath.row]
        cell.label.text = cinema.name
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cinema = data[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
         let cinemaVC = sb.instantiateViewController(withIdentifier: "cinemaVC") as! CinemaTableViewController
        cinemaVC.cinema = cinema
         navigationController?.pushViewController(cinemaVC, animated: true)

       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //   if segue.identifier == "showCinemaDetail"{
       //    let cell = collectionView.cellForItem(at: selectedIndexPath!) as! CustomCollectionViewCell
        //    let destinaationVC = segue.destination as! CinemaViewController
          //  destinaationVC.headerString = cell.label.text
      //  }
        
      //  let sb = UIStoryboard(name: "Main", bundle: nil)
       // let cinemaVC = sb.instantiateViewController(withIdentifier: "cinemaVC") as! CinemaViewController
       // cinemaVC.headerString = cell.label.text
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
 //   }
 
    
  

}
