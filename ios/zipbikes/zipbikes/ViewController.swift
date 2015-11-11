//
//  ViewController.swift
//  zipbikes
//
//  Created by Devvret Rishi on 11/9/15.
//  Copyright © 2015 Devvret Rishi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        mapView.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
        let price = 2.50 as Float
        let rating = 4
        var infoStr = "Bike 1" + "\n" + "Rating : " + String(rating) + " out of 5" + "\n" + "Price per day $" + String(price)
        
        let b1 = Bike(title: "Bike 1", coordinate: CLLocationCoordinate2D(latitude: location!.coordinate.latitude + 0.005, longitude: location!.coordinate.longitude+0.01), info: infoStr, price: price, rating: rating )
        //        mapView.addAnnotation(b1)
        
        let b2 = Bike(title: "Bike 2", coordinate: CLLocationCoordinate2D(latitude: location!.coordinate.latitude - 0.008, longitude: location!.coordinate.longitude - 0.015), info: infoStr, price: price, rating: rating)
        mapView.addAnnotations([b1, b2])
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!{
        let identifier = "Bicycle"
        if annotation.isKindOfClass(Bike.self){
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            if annotationView == nil{
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            }
            else{
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        
        return nil
    }
    
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        let capital = view.annotation as! Bike
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    
}

