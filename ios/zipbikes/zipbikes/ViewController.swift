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
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
        let price = 2.50 as Float
        let rating = 4
        var infoStr = "Bike 1" + "\n" + "Rating : " + String(rating) + " out of 5" + "\n" + "Price per day $" + String(price)
        
        let b1 = Bike(title: "Bike 1", coordinate: CLLocationCoordinate2D(latitude: location!.coordinate.latitude + 0.005, longitude: location!.coordinate.longitude+0.01), info: infoStr, price: price, rating: rating )
        //        mapView.addAnnotation(b1)
        
        let b2 = Bike(title: "Bike 2", coordinate: CLLocationCoordinate2D(latitude: location!.coordinate.latitude - 0.008, longitude: location!.coordinate.longitude - 0.015), info: infoStr, price: price, rating: rating)
        
        let b3 = Bike(title: "Bike 3", coordinate: CLLocationCoordinate2D(latitude: location!.coordinate.latitude - 0.002, longitude: location!.coordinate.longitude + 0.0015), info: infoStr, price: price, rating: rating)
        
        mapView.addAnnotations([b1, b2, b3])
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
        let bikeCoords = capital.coordinate
        
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .Alert)
//        ac.addAction(UIAlertAction(title: "Reserve Bicycle", style: .Default, handler: nil))
//        presentViewController(ac, animated: true, completion: nil)
        
        let ac = UIAlertController(title: "Reserve a Bike", message: placeInfo, preferredStyle: .Alert)
        let act = UIAlertAction(title: "Reserve", style: UIAlertActionStyle.Default, handler: unlockMenu)
        ac.addAction(act)
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
        
    }
    
    func unlockMenu(alert: UIAlertAction!){
        let ac2 = UIAlertController(title: "UNLOCK", message: "Please make sure you are near the bicycle before unlocking", preferredStyle: .ActionSheet)
        ac2.addAction(UIAlertAction(title: "Unlock", style: UIAlertActionStyle.Default, handler: unlockHandler))
        presentViewController(ac2, animated: true, completion: nil)
    }
    
    func unlockHandler(alert: UIAlertAction){
        
        //TODO Implement the Logic to communicate with the server and the lock to unlock the bike!
        
        //let location = locations.last
        //let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
//        let newCoord = CLLocationCoordinate2D(latitude: 39.2014, longitude: 41.0142)
//        var region = MKCoordinateRegion(center: newCoord, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//        region = mapView.regionThatFits(region)
//        self.mapView.setRegion(region, animated: true)
        
        let ac3 = UIAlertController(title: "Thank you!", message: "Remember to lock your bike when you are done with your rental", preferredStyle: .Alert)
        ac3.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(ac3, animated: true, completion: nil)
        
    }
    
}

