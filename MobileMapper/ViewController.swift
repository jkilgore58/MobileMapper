//
//  ViewController.swift
//  MobileMapper
//
//  Created by Jonathan Kilgore on 2/2/16.
//  Copyright © 2016 Jonathan Kilgore. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let mobileMakersAnnotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        
        super.viewDidLoad()
        
        //Mobile Makers coordinates via GoogleMaps: 41.8937362(lat),-87.6375008(long)
        
        let latitude = 41.8937362
        let longtitude = -87.6375008
        
        mobileMakersAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longtitude)
        mobileMakersAnnotation.title = "Mobile Makers HQ"
        mapView.addAnnotation(mobileMakersAnnotation)
        
        //let address = "Yosemite National Park"
        dropPinForLocation("Yosemite National Park")
        dropPinForLocation("Yellowstone National Park")

    }
    
    func dropPinForLocation(address: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
            for placemark in placemarks!
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark.location?.coordinate)!
                annotation.title = placemark.name
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation)
        {
            return nil
        } else if annotation.isEqual(mobileMakersAnnotation) {
        
        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.image = UIImage(named: "mobilemakers")
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        
        return pin
            
        } else {
            
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.canShowCallout = true
            pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            
            return pin
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        mapView.setRegion(MKCoordinateRegionMake(view.annotation!.coordinate, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
    }

}

