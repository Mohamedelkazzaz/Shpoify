//
//  indecator.swift
//  Shopify_app
//
//  Created by Ahmed Hussien on 13/12/1443 AH.
//

import Foundation
import UIKit
import ProgressHUD

struct Indectore{
    static func initIndecatore(){
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.colorAnimation = UIColor(named: "mainColor")!
        ProgressHUD.show()
    }
}
