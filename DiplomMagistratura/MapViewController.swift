//
//  MapViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 26.02.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let data = ["1", "2", "3", "4"]
    var selectedIndexPath: IndexPath?
    //let colors: [UIColor] = [.red, .green, .gray, .darkGray]
    
    // MARK: - IBOUtlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var collectionView: UICollectionView!

   
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
      
          if let path =  Bundle.main.path(forResource: "MapHTMLCode", ofType: "html") {
            print("ok")
            let url = URL(fileURLWithPath: path)
            webView.loadRequest(URLRequest(url: url))
          }else{
            print("not ok")
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.sizeThatFits(CGSize(width: collectionView.frame.width, height: collectionView.frame.height))
        cell.label.text = data[indexPath.row]
        //cell.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
          let cell = collectionView.cellForItem(at: selectedIndexPath!) as! CustomCollectionViewCell
        let sb = UIStoryboard(name: "Main", bundle: nil)
         let cinemaVC = sb.instantiateViewController(withIdentifier: "cinemaVC") as! CinemaViewController
         cinemaVC.headerString = cell.label.text
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
