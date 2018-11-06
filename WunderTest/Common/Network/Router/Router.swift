//
//  Router.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Foundation

import Alamofire

enum Router: URLRequestConvertible {
  
  case getPlacemarks
  
  fileprivate var method: HTTPMethod {
    switch self {
    case .getPlacemarks:
      return .get
    }
  }
  
  fileprivate var path: String {
    switch self {
    case .getPlacemarks:
      return "/wunderbucket/locations.json"
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = Constants.API.URLBase
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    
    // Parameters
    switch self {
    case .getPlacemarks:
      urlRequest = try JSONEncoding.default.encode(urlRequest)
    }
    
    return urlRequest
  }
}
