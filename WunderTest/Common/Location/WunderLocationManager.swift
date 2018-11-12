//
//  WunderLocationManager.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/12/18.
//  Copyright © 2018 Danijel Kecman. All rights reserved.
//

import CoreLocation

@objc class WunderLocationManager: NSObject {
  
  // MARK: - Properties -
  
  internal static let maximumDesiredLocationAccuracyInVisit = kCLLocationAccuracyHundredMeters
  
  @objc static let shared = WunderLocationManager()
  private override init() {}
  
  @objc var maximumDesiredLocationAccuracy: CLLocationAccuracy = 60
  @objc var dynamicallyAdjustDesiredAccuracy: Bool = true
  @objc var locationManagerDelegate: CLLocationManagerDelegate?
  var currentLocation: CLLocation?
  
  @objc private(set) lazy var locationManager: CLLocationManager = {
    let manager = CLLocationManager()
    manager.distanceFilter = kCLDistanceFilterNone
    manager.desiredAccuracy = self.maximumDesiredLocationAccuracy
    manager.pausesLocationUpdatesAutomatically = false
    
    manager.delegate = self
    return manager
  }()
  
  private var _recordingState: RecordingState = .off
  
  /**
   The WunderLocationManager's current `RecordingState`.
   */
  private(set) var recordingState: RecordingState {
    get {
      return _recordingState
    }
    set(newValue) {
      _recordingState = newValue
    }
  }
  
  /**
   The most recently received raw CLLocation.
   */
  var rawLocation: CLLocation? {
    return locationManager.location
  }
  
  /**
   A convenience wrapper for `CLLocationManager.authorizationStatus()`.
   
   Returns true if status is either `authorizedWhenInUse` or `authorizedAlways`.
   */
  var haveLocationPermission: Bool {
    let status = CLLocationManager.authorizationStatus()
    return status == .authorizedWhenInUse || status == .authorizedAlways
  }
  
  /**
   A convenience wrapper for `CLLocationManager.authorizationStatus()`.
   
   Returns true if status is `authorizedAlways`.
   */
  var haveBackgroundLocationPermission: Bool {
    return CLLocationManager.authorizationStatus() == .authorizedAlways
  }
  
  func startRecording() {
    if recordingState == .recording {
      return
    }
    
    guard haveLocationPermission else {
      return
    }
    
    if haveBackgroundLocationPermission {
      locationManager.allowsBackgroundLocationUpdates = true
    }
    locationManager.desiredAccuracy = maximumDesiredLocationAccuracy
    locationManager.showsBackgroundLocationIndicator = false
    locationManager.distanceFilter = kCLDistanceFilterNone
    locationManager.startUpdatingLocation()
    
    recordingState = .recording
  }
  
  func stopRecording() {
    if recordingState == .off {
      return
    }
    
    // stop the location manager
    locationManager.stopUpdatingLocation()
    
    recordingState = .off
  }
  
  /**
   A convenience wrapper for the `CLLocationManager` authorisation request methods.
   
   You can also interact directly with the internal `locationManager` to perform these tasks.
   
   - Parameters:
   - background: If `true`, will call `requestAlwaysAuthorization()`, otherwise `requestWhenInUseAuthorization()`
   will be called. Default value is `false`.
   */
  func requestLocationPermission(background: Bool = false) {
    if background {
      locationManager.requestAlwaysAuthorization()
    } else {
      locationManager.requestWhenInUseAuthorization()
    }
  }
}

// MARK: - Motion Manager - Location Delegates -

extension WunderLocationManager: CLLocationManagerDelegate {
  
  // MARK: - CLLocationManagerDelegate Authorization -
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // broadcast a notification
    EventBus.post(Constants.EventBus.didChangeAuthorizationStatus, sender: status)
    
    // forward the delegate event
    locationManagerDelegate?.locationManager?(manager, didChangeAuthorization: status)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    // broadcast a notification
    EventBus.post(Constants.EventBus.didFailWithError, sender: error)
    
    // forward the delegate event
    locationManagerDelegate?.locationManager?(manager, didFailWithError: error)
  }
  
  // MARK: - CLLocationManagerDelegate Location -
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // ignore incoming locations that arrive when we're not supposed to be listen
    if recordingState != .recording {
      return
    }
  
    EventBus.post(Constants.EventBus.didUpdateLocation, sender: locations)
    
    // forward the delegate event
    locationManagerDelegate?.locationManager?(manager, didUpdateLocations: locations)
  }
  
}

/**
 The recording state of the WunderLocationManager.
 */
enum RecordingState: String, Codable {
  case recording
  case off
}
