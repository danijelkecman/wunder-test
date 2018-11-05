//
//  APIError.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation

enum APIError: Error {
  case message(String)
  
  var localizedDescription: String {
    switch self {
    case .message(let string):
      return string
    }
  }  
}
