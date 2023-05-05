//
//  ViewController.swift
//  mapTest
//
//  Created by Uma Pulugurtha on 4/28/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet private var mapView: MKMapView! = MKMapView()
    let refreshControl = UIRefreshControl()
    
    var events: [Event]
    
    init(events: [Event]){
        self.events = events
        super.init(nibName: nil, bundle: nil)
                    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

//        if #available(iOS 10.0, *) {
//            //contentView = mapView
//            //contentView.refreshControl = refreshControl
//        } else {
//            //mapView.addSubview(refreshControl)
//        }

        
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height)
    
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        
        let initialLocation = CLLocation(latitude: 42.447464, longitude: -76.482592)
              
        mapView.centerToLocation(initialLocation)
        
        addAllEvents()
        
        view.addSubview(mapView)
                
    }
    
    func getLocation(from address: String, completion: (_ location: Result<CLLocationCoordinate2D?, Error>) async throws -> [CLPlacemark]) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            print("in the geocoder")
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                //completion(.failure(error!))
                return
            }
            //completion(.success(location))
        }
    }
    
    func getAnnotationsFromLocation(address: String)-> MKPointAnnotation {
            //return locations.map { location in
                let geocoder = CLGeocoder()
                let annotation = MKPointAnnotation()
                
                geocoder.geocodeAddressString(address) { placemarks, error in
                    guard let placemark = placemarks?.first, let location = placemark.location else {
                        return
                    }
                    annotation.coordinate = location.coordinate
                    annotation.title = placemark.name
                }
                
                return annotation
            }
        
    
    
//    func getLocation(from address: String){
//        let geoCoder = CLGeocoder()
//        var geocoder = CLGeocoder()
//        geocoder.geocodeAddressString("your address") {
//            placemarks, error in
//            let placemark = placemarks?.first
//            let lat = placemark?.location?.coordinate.latitude
//            let lon = placemark?.location?.coordinate.longitude
//            print("Lat: \(lat), Lon: \(lon)")
//        }
//    }
    
    func addAllEvents(){
        for event in self.events{
           addEvent(event: event)
        }
    }
    
    //adds event to map
    func addEvent(event: Event){
        
        let arbEvent = getAnnotationsFromLocation(address: event.address)
        arbEvent.title = event.title
//        arbEvent.coordinate = CLLocationCoordinate2D(latitude: getLatitudeFromLoc(address: event.address), longitude: getLongitudeFromLoc(address: event.address))
        print(arbEvent.coordinate)
        mapView.addAnnotation(arbEvent)
        
    }
    
//    func getLatitudeFromLoc(address: String) -> CLLocationDegrees {
//        let group = DispatchGroup()
//        //group.enter()
//        var latitude: CLLocationDegrees = 0.0
////        DispatchQueue.global(qos: .default).async {
//            // Function call here
//            self.getLocation(from: address) { result in
//
//                switch result {
//                    case .failure(let error):
//                        print("fail")
//
//
//                    // update UI to report error, if any
//                    case .success(let location):
//                    latitude = location!.latitude
//                    //return latitude
//                    // update UI to show address
//                    }
//
//                //latitude = location?.latitude ?? 0.0
//                //print(latitude)
//                //group.leave()
//            }
//            //group.leave()
////        }
//        //group.notify
//        print(latitude)
//        return latitude
//    }
//
//    func getLongitudeFromLoc(address: String) -> CLLocationDegrees {
//        let group = DispatchGroup()
//        //group.enter()
//        var latitude: CLLocationDegrees = 0.0
////        DispatchQueue.global(qos: .default).async {
//            // Function call here
//            self.getLocation(from: address) { result in
//
//                switch result {
//                    case .failure(let error):
//                        print("fail")
//
//
//                    // update UI to report error, if any
//                    case .success(let location):
//                    latitude = location!.longitude
//                    //return latitude
//                    // update UI to show address
//                    }
//
//                //latitude = location?.latitude ?? 0.0
//                //print(latitude)
//                //group.leave()
//            }
//            //group.leave()
////        }
//        //group.notify
//        print(latitude)
//        return latitude
//    }
//
//    func getLongitudeFromLoc(address: String) -> CLLocationDegrees {
//        let group = DispatchGroup()
//        //group.enter()
//        var longitude: CLLocationDegrees = 0.0
//        DispatchQueue.global(qos: .default).async {
//            // Function call here
//            self.getLocation(from: address) { location in
//                longitude = location?.longitude ?? 0.0
//                //group.leave()
//            }
//            //group.leave()
//        }
//        //group.wait()
//        print(longitude)
//        return longitude
//    }
    
//    func getLongitudeFromLoc(address: String)-> CLLocationDegrees{
//        let group = DispatchGroup()
//        group.enter()
//        var longitude: CLLocationDegrees = 0.0
//        print(address)
//        getLocation(from: address) { location in
//            longitude = location?.longitude ?? 0.0
//            print("in the get location funx")
//            print(longitude)
//            group.leave()
//        }
//        group.wait()
//        print("outside the get loc func")
//        print(longitude)
//        return longitude
//    }
    
    @objc func refreshData() {
        
            NetworkManager.shared.getAllEvents { events in
                DispatchQueue.main.async {
                    self.events = events
                    //self.mapView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
        }
        
    
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
  }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("I was clicked")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
