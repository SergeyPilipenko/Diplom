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
    
    func createDictionaryForDetailDescription(titles: Array<String>, strings: Any?...) -> (Array<String>, Array<String>){
        
        var finalTitles = Array<String>()
        var finalDetails = Array<String>()
        
        for(index, value) in strings.enumerated() {
            if let s = value as? String{
                if !s.isEmpty {
                    finalDetails.append(s)
                    finalTitles.append(titles[index])
                }
               
            }  else if let arr = value as? Array<String> {
                if !arr.isEmpty{
                    var str = ""
                    if arr.count > 3{
                        for index in 1...3 {
                          str += "\(arr[index]), "
                        }
                    } else {
                        for (_, value) in arr.enumerated(){
                            str += "\(value), "
                        }
  
                    }
                    
                    let endIndex = str.index(str.endIndex, offsetBy: -2)
                    var truncated = str.substring(to: endIndex)
                    
                    finalDetails.append(truncated)
                    finalTitles.append(titles[index])
                }
            }
        }
     return (finalTitles, finalDetails)
    }
}

