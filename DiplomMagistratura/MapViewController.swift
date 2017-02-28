//
//  MapViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 26.02.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    let data = ["Spartak", "Proletka", "CinemaPark"]
    
    var views = [UIView]()
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var snap: UISnapBehavior!
    var previousTouchPoint: CGPoint!
    var viewDragging = false
    var viewPinned = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //Bundle.main.path(forResource: "MapHTMLCode", ofType: "html")
        //if let path = Bundle.main.path(forResource: "MapHTMLCode", ofType: "html", inDirectory: "Supports")
          if let path =  Bundle.main.path(forResource: "MapHTMLCode", ofType: "html") {
            print("ok")
            let url = URL(fileURLWithPath: path)
            webView.loadRequest(URLRequest(url: url))
          }else{
            print("not ok")
        }
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        
        animator.addBehavior(gravity)
        gravity.magnitude = 4
    

        // Do any additional setup after loading the view.
    }

    
    
    func addChildViewController(atOffset offset: CGFloat, dataForVC data: AnyObject?) ->UIView? {
        let frameForView = self.view.bounds.offsetBy(dx: 0, dy: self.view.bounds.size.height - offset)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let cinemaVC = sb.instantiateViewController(withIdentifier: "cinemaVC")
        if let view = cinemaVC.view{
            view.frame = frameForView
            
            if let headingStr = data as? String{
                cinemaVC.headerString = headingStr
            }
            
            self.addChildViewController(cinemaVC)
            self.view.addSubview(view)
            cinemaVC.didMove(toParentViewController: self)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
