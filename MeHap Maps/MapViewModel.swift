//
//  MapViewModel.swift
//  MeHap Maps
//
//  Created by Josiah Cilladi on 10/9/22.
//
// -Deals with Displayed Map and Location Privacy-

//TODO change to MKMap

import MapKit


enum MapDetails {
    
    static let staringLocation = CLLocationCoordinate2D(latitude: 41.10119 , longitude: -71.09922)
    
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    
    
    
    
}


// TODO Recreat MapViewModel with New MK Map View
final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    
    
    
    @Published var region = MKCoordinateRegion(center: MapDetails.staringLocation,
                                          span: MapDetails.defaultSpan)
    
    // TODO : impliment a point of interest filter
    @Published var pointsOfIntrest = MKPointOfInterestFilter(including: [.nationalPark])

    
    
    
    // ? is optional
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            // look at Documenttion for what location setting there are for hiking app
            //locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        }else {
            print("show that location is turned off and to have the user go turn in on.")
        }
        
    }
    
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(
                latitudeDelta: 0.005, longitudeDelta: 0.005))
        @unknown default:
            break
        }
        
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}


