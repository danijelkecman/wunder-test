//
//  PartialURL.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation

struct PartialURL: Codable {
  
  let url: URL?
  
  init(from decoder: Decoder) throws {
    let urlString = try decoder.singleValueContainer().decode(String.self)
    let url = Constants.API.URLBase.appendingPathComponent(urlString)
    
    self.url = url
  }
  
}
