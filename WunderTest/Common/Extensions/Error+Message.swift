//
//  Error+Message.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation
import Alamofire

extension Error {
  
  var message: String? {
    if self is AFError {
      return "Unknown error"
    } else if let error = self as? APIError {
      return error.localizedDescription
    } else {
      return self.localizedDescription
    }
  }
  
}
