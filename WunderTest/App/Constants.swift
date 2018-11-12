//
//  Constants.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/6/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation

struct Constants {
  
  struct API {
    static let URLBase = URL(string: "https://s3-us-west-2.amazonaws.com")!
  }
  
  struct EventBus {
    static let didLoadPlacemarksEvent: String = "didLoadPlacemarksEvent"
  }
  
}
