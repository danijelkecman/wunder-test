//
//  AlamofireInitializer.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityIndicator

class AlamofireInitializer: Initializable {
  
  func performInitialization() {
    let networkActivityManager = NetworkActivityIndicatorManager.shared
    networkActivityManager.isEnabled = true
    networkActivityManager.startDelay = 0
  }
  
}
