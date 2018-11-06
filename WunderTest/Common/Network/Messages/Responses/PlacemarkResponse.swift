//
//  Placemark.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation

struct PlacemarkResponse: Codable {
  
  struct Placemark {
    let address: String
    let coordinates: [Double]
    let engineType: String
    let exterior: String
    let fuel: Int
    let interior: String
    let name: String
    let vin: String
    
    func toPlacemark() -> Placemark {
      return Placemark(address: address,
                       coordinates: coordinates,
                       engineType: engineType,
                       exterior: exterior,
                       fuel: fuel,
                       interior: interior,
                       name: name,
                       vin: vin)
    }
  }
}
