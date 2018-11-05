//
//  SVProgressHudInitializer.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation
import SVProgressHUD

class SVProgressHudInitializer: Initializable {
  
  func performInitialization() {
    SVProgressHUD.setForegroundColor(UIColor.white)
    SVProgressHUD.setDefaultStyle(.dark)
  }
  
}
