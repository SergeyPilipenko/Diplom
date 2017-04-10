//
//  Extensions.swift
//  DiplomMagistratura
//
//  Created by Admin on 10.04.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func addConstraintsWithFormat(format: String, views: UIView...){
        
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

extension NSObject {
    
    func createDictionaryForDetailDescription(strings: String?...) -> Dictionary<Int, String>{
        
        var dict = [Int: String]()
        for(index, str) in strings.enumerated() {
            if let s = str{
                dict[index] = s
            } else {
                dict[index] = ""
            }
        }
        
        return dict
    }
}
