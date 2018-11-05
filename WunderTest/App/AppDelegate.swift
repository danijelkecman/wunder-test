//
//  AppDelegate.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  lazy var initializers: [Initializable] = [
    AlamofireInitializer(),
    SVProgressHudInitializer()
  ]
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    initializers.forEach { $0.performInitialization() }
    
    let initialController = WunderNavigationController()
    initialController.setRootWireframe(MainWireframe())
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    self.window?.rootViewController = initialController
    self.window?.makeKeyAndVisible()
    
    return true
  }
}


