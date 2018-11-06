//
//  AlamofireExtensions.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import Alamofire

// MARK: - Logging -

extension DataRequest {
  
  public func debugLog() -> Self {
    let logString = "===== 🚀 REQUEST 🚀 =====" + "\n" + debugDescription
    log.verbose(logString)
    return self
  }
  
}

extension DataResponse {
  public func debugLog() {
    var logString = "===== ✨ RESPONSE ✨ =====" + "\n\n"
    
    guard let data = data, let jsonString = String(data: data, encoding: String.Encoding.utf8) else {
      logString += "🔴 ERROR: " + "\n" + "\(debugDescription)" + "\n"
      log.error(logString)
      return
    }
    
    logString += "🔷 RESPONSE:" + "\n" + "\(debugDescription)" + "\n\n"
    
    switch result {
    case .success(let value):
      logString += jsonString + "\n\n"
      logString += "🔶 SUCCESSFULLY DESERIALIZED: " + "\n" + String(describing: type(of: value)) + "\n\n"
      log.verbose(logString)
    case .failure(let error):
      logString += jsonString + "\n"
      logString += "🔴 ERROR: " + "\n" + "\(error)" + "\n\n"
      log.error(logString)
    }
  }
}
