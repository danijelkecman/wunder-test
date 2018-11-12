//
//  MainPresenter.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/12/18.
//  Copyright (c) 2018 Danijel Kecman. All rights reserved.
//

import Foundation

class EventBus {
  
  struct Static {
    static let instance = EventBus()
    static let queue = DispatchQueue(label: "com.cxromos.EventBus", attributes: [])
  }
  
  struct NamedObserver {
    let observer: NSObjectProtocol
    let name: String
  }
  
  var cache = [UInt: [NamedObserver]]()
  
  //MARK: - Publish -
  
  class func post(_ name: String, sender: Any? = nil) {
    NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
  }
  
  class func post(_ name: String, sender: NSObject?) {
    NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
  }
  
  class func post(_ name: String, sender: Any? = nil, userInfo: [AnyHashable: Any]?) {
    NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender, userInfo: userInfo)
  }
  
  class func postToMainThread(_ name: String, sender: Any? = nil) {
    DispatchQueue.main.async {
      NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
    }
  }
  
  class func postToMainThread(_ name: String, sender: NSObject?) {
    DispatchQueue.main.async {
      NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender)
    }
  }
  
  class func postToMainThread(_ name: String, sender: Any? = nil, userInfo: [AnyHashable: Any]?) {
    DispatchQueue.main.async {
      NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: sender, userInfo: userInfo)
    }
  }
  
  
  
  //MARK: - Subscribe -
  
  @discardableResult
  class func on(_ target: AnyObject, name: String, sender: Any? = nil, queue: OperationQueue?, handler: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
    let id = UInt(bitPattern: ObjectIdentifier(target))
    let observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: sender, queue: queue, using: handler)
    let namedObserver = NamedObserver(observer: observer, name: name)
    
    Static.queue.sync {
      if let namedObservers = Static.instance.cache[id] {
        Static.instance.cache[id] = namedObservers + [namedObserver]
      } else {
        Static.instance.cache[id] = [namedObserver]
      }
    }
    
    return observer
  }
  
  @discardableResult
  class func onMainThread(_ target: AnyObject, name: String, sender: Any? = nil, handler: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
    return EventBus.on(target, name: name, sender: sender, queue: OperationQueue.main, handler: handler)
  }
  
  @discardableResult
  class func onBackgroundThread(_ target: AnyObject, name: String, sender: Any? = nil, handler: @escaping ((Notification) -> Void)) -> NSObjectProtocol {
    return EventBus.on(target, name: name, sender: sender, queue: OperationQueue(), handler: handler)
  }
  
  //MARK: - Unregister -
  
  class func unregister(_ target: AnyObject) {
    let id = UInt(bitPattern: ObjectIdentifier(target))
    let center = NotificationCenter.default
    
    Static.queue.sync {
      if let namedObservers = Static.instance.cache.removeValue(forKey: id) {
        for namedObserver in namedObservers {
          center.removeObserver(namedObserver.observer)
        }
      }
    }
  }
  
  class func unregister(_ target: AnyObject, name: String) {
    let id = UInt(bitPattern: ObjectIdentifier(target))
    let center = NotificationCenter.default
    
    Static.queue.sync {
      if let namedObservers = Static.instance.cache[id] {
        Static.instance.cache[id] = namedObservers.filter({ (namedObserver: NamedObserver) -> Bool in
          if namedObserver.name == name {
            center.removeObserver(namedObserver.observer)
            return false
          } else {
            return true
          }
        })
      }
    }
  }
}
