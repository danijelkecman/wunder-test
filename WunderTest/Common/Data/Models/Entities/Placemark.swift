//
//  Placemark.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation

struct Placemarks: Codable {
  let placemarks: [Placemark]
}

struct Placemark: Codable {
  let address: String
  let coordinates: [Double]
  let engineType: String
  let exterior: String
  let fuel: Int
  let interior: String
  let name: String
  let vin: String
}
