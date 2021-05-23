import Foundation
import CoreLocation

class Location :NSObject{
    static let shared = Location()
    var lastKnownLocation: LatLng?
    private var location:CLLocationManager
    
    var locationGranted: Bool?
    //Initializer access level change now
    private override init(){
        self.location = CLLocationManager()
        super.init()
        self.location.delegate = self
        self.location.desiredAccuracy = kCLLocationAccuracyBest
        self.location.distanceFilter = kCLLocationAccuracyHundredMeters
        
        
        
    }
    
    
    
    
    func requestAuthorization(){
        var status : CLAuthorizationStatus!
        if #available(iOS 14.0, *){
            status = CLLocationManager().authorizationStatus
        }else{
            status = CLLocationManager.authorizationStatus()
            
        }
        switch status {
        case .authorizedAlways,.authorizedWhenInUse :
            location.requestLocation()
        // Handle case
        case .denied, .restricted:
            lastKnownLocation = LatLng(lat: 40.754910, lng: -73.994102) //Times Squre as def
        case .notDetermined:
            location.requestAlwaysAuthorization()
        default: break
            
        }
    }
    func requestForLocation() -> LatLng?{
        location.requestLocation()
        locationGranted = true
        return lastKnownLocation ?? nil
    }
    
    
}

//MARK:- Get the location
extension Location: CLLocationManagerDelegate{
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestAuthorization()
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            lastKnownLocation = LatLng(lat: latitude, lng: longitude)
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        NSLog("Error in location: \(error)")
    }
    
    
    
    
}
