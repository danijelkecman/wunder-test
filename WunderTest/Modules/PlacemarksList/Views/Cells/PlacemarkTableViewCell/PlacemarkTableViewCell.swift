//
//  PlacemarkTableViewCell.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/12/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import UIKit
import Reusable

class PlacemarkTableViewCell: UITableViewCell, NibReusable {
  
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var coordinatesLabel: UILabel!
  @IBOutlet weak var engineTypeLabel: UILabel!
  @IBOutlet weak var exteriorLabel: UILabel!
  @IBOutlet weak var fuelLabel: UILabel!
  @IBOutlet weak var interiorLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var vinLabel: UILabel!
  
  func configure(with item: PlacemarkCellItem) {
    addressLabel.text = "Address: \(item.address)"
    coordinatesLabel.text = "Coordinates: \(item.coordinates.map({"\($0)"}).joined(separator: ","))"
    engineTypeLabel.text = "Engine type: \(item.engineType)"
    exteriorLabel.text = "Exterior: \(item.exterior)"
    fuelLabel.text = "Fuel: \(item.fuel)"
    interiorLabel.text = "Interior: \(item.interior)"
    nameLabel.text = "Name: \(item.name)"
    vinLabel.text = "VIN: \(item.vin)"
  }
}
