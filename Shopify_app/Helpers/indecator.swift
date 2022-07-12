//
//  indecator.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 13/12/1443 AH.
//

import Foundation
import UIKit
import NVActivityIndicatorView

struct Indectore{
    static func createIndecatore(loadingIndecator:NVActivityIndicatorView){
            loadingIndecator.color =  UIColor(named: "mainColor")!
            loadingIndecator.type = .ballSpinFadeLoader
            loadingIndecator.padding = 120
            loadingIndecator.startAnimating()
       // loadingIndecator.frame =  CGRect(x: 0, y: 0, width: 150, height: 150)
       // center = view.center
    }
}
