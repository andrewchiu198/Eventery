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
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

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
    
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(location)
        }
    }
    
    func addAllEvents(){
        for event in self.events{
           addEvent(event: event)
        }
    }
    
    func addEvent(event: Event){
        let arbEvent = MKPointAnnotation()
        arbEvent.title = event.title
        arbEvent.coordinate = CLLocationCoordinate2D(latitude: getLatitudeFromLoc(address: event.address), longitude: getLongitudeFromLoc(address: event.address))
        mapView.addAnnotation(arbEvent)
    }
    
    func getLatitudeFromLoc(address: String) -> CLLocationDegrees{
        var latitude: CLLocationDegrees = 0.0
        getLocation(from: address) { location in
            latitude = location?.latitude ?? 0.0
            
        }
        return latitude
    }
    
    func getLongitudeFromLoc(address: String)-> CLLocationDegrees{
        var longitude: CLLocationDegrees = 0.0
        print(address)
        getLocation(from: address) { location in
            longitude = location?.latitude ?? 0.0
            print("in the get location funx")
            print(longitude)
        }
        print("outside the get loc func")
        print(longitude)
        return longitude
    }
    
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
