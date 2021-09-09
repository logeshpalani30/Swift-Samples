//
//  ViewController.swift
//  MapView
//
//  Created by Logesh Palani on 08/09/21.
//
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var maptypes = ["Hybrid": MKMapType.hybrid,"HybridFlyover": MKMapType.hybridFlyover, "MutedStandard" : MKMapType.mutedStandard, "Satellite":MKMapType.satellite, "Default": MKMapType.standard]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        mapView.addAnnotations([london, oslo,paris,rome,washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(changeMapType))
        
        mapView.mapType = .satelliteFlyover
        
    }
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Select Map Type", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: mapTypeSelected))
        ac.addAction(UIAlertAction(title: "HybridFlyover", style: .default, handler: mapTypeSelected))
        ac.addAction(UIAlertAction(title: "MutedStandard", style: .default, handler: mapTypeSelected))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: mapTypeSelected))
        ac.addAction(UIAlertAction(title: "Default", style: .default, handler: mapTypeSelected))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    func mapTypeSelected(action: UIAlertAction) {
        guard let title = action.title else {
            return
        }
        mapView.mapType = maptypes[title]!
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {
            return nil
        }
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Captial") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.red
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
            
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {
           return
        }
        let place = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: place, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

