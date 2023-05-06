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
    
    static let shared = MapViewController()
    
    var events: [Event] = []
    
    init(events: [Event]){
        self.events = events
        super.init(nibName: nil, bundle: nil)
                    
    }
    
    init(){
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
    
    
    func getAnnotationsFromLocation(address: String)-> MKPointAnnotation {
            //return locations.map { location in
                let geocoder = CLGeocoder()
                let annotation = MKPointAnnotation()
                
                geocoder.geocodeAddressString(address) { placemarks, error in
                    guard let placemark = placemarks?.first, let location = placemark.location else {
                        return
                    }
                    annotation.coordinate = location.coordinate
                    //annotation.title = placemark.name
                }
                
                return annotation
            }
        
    
    func addAllEvents(){
        mapView.removeAnnotations(mapView.annotations)
        for event in self.events{
           addEvent(event: event)
        }
    }
    
    //adds event to map
    func addEvent(event: Event){
        let arbEvent = getAnnotationsFromLocation(address: event.address)
        arbEvent.title = event.title
        print(arbEvent.coordinate)
        mapView.addAnnotation(arbEvent)
    }
    

    @objc func refreshData() {
        
            NetworkManager.shared.getAllEvents { events in
                DispatchQueue.main.async {
                    self.events = events
                    //self.mapView.reloadData()
                    //self.refreshControl.endRefreshing()
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
        //let vc = LearnMoreViewController(event: cell.event)
        //navigationController?.pushViewController(vc, animated: true)
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
