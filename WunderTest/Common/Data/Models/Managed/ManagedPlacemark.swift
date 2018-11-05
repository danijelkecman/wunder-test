//
//  ManagedPlacemark.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import CoreData

class ManagedPlacemark: NSManagedObject {
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

extension ManagedPlacemark {
  @NSManaged var address: String
  @NSManaged var coordinates: [Double]
  @NSManaged var engineType: String
  @NSManaged var exterior: String
  @NSManaged var fuel: Int
  @NSManaged var interior: String
  @NSManaged var name: String
  @NSManaged var vin: String
}
