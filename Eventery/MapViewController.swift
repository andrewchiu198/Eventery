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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 42.447464, longitude: -76.482592)
        
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height)
        
        //tabBarController!.tabBar.frame.height + 10
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        
        let hoyRoad = MKPointAnnotation()
        hoyRoad.title = "hoy road"
        hoyRoad.coordinate = CLLocationCoordinate2D(latitude: 42.4428052, longitude: -76.4786648)
        mapView.addAnnotation(hoyRoad)
        mapView.centerToLocation(initialLocation)
        
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
    
    func getLatitudeFromLoc(address: String) -> Double{
        var latitude = 0.0
        getLocation(from: address) { location in
            latitude = location?.latitude ?? 0.0
            
        }
        return latitude
    }
    
    func getLongitudeFromLoc(address: String)-> Double{
        var longitude = 0.0
        getLocation(from: address) { location in
            longitude = location?.latitude ?? 0.0
            
        }
        return longitude
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
