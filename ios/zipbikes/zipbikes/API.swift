//
//  API.swift
//  zipbikes
//
//  Created by Michelle Deng on 12/1/15.
//  Copyright © 2015 Devvret Rishi. All rights reserved.
//

import Foundation
import CoreLocation

class API {
    let session = NSURLSession.sharedSession()
    var mapController: ViewController

    init(controller: ViewController) {
        self.mapController = controller
    }
    
    func getBikes()-> Void {
        let url = NSURL(string: "http://zipbikes.co/core/map/")!
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        //request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = session.dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            
            var bikes = [Bike]()
            
            if let bikejsons = json["bikes"] as? NSArray {
                print(bikejsons)
                
                for var i = 0; i < bikejsons.count; i++ {
                    let bikejson = bikejsons[i]
                    
                    let lat = (bikejson["lat"] as! NSNumber).doubleValue
                    let lon = (bikejson["lon"] as! NSNumber).doubleValue
                    
                    let id = (bikejson["id"] as! NSNumber).integerValue
                    
                    let bike = Bike(id: id,
                        title: "Bike " + String(id),
                        coordinate: CLLocationCoordinate2D(latitude: lat as CLLocationDegrees,
                            longitude: lon as CLLocationDegrees),
                        price: bikejson["price"] as! Float,
                        rating: bikejson["rating"] as! Float)
                    
                    bikes.append(bike)
                    
                    print(bike.infoString())
                }
            }
            
            self.mapController.refreshBikes(bikes)
        }
        dataTask.resume()
    }
    
    
    func getUnlockKey(userId: Int, bikeID: Int)-> Void {
        let url = NSURL(string: "http://zipbikes.co/core/unlock/")!
        
        let postString: NSString = "user_id=\(userId)&bike_id=\(bikeID)"
        let postData: NSData = postString.dataUsingEncoding(NSASCIIStringEncoding)!
        let postLength: NSString = String(postData.length)
        NSLog("PostData: %@", postString);

        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = session.dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print("unlock json: ")
            print(json)
            print("\n\n\n")
            
            if let success = json["success"] as? Bool {
                if success {
                    let key = json["key"] as! NSString
                    // TODO unlock the bike using the key! uncomment below once implemented
                    // self.mapController.unlockBikeWithKey(bikeID, key)

                } else {
                    let error = json["error"] as! NSString
                    print(error)
                    // TODO error handling: uncomment below once it's implemented
                    // self.mapController.unlockBikeError(bikeID, error)
                }
            } else {
                print("no \"success\" field in response from server")
            }
        }
        dataTask.resume()
    }
    
    func doLock(userId: Int, bikeID: Int, lat: Double, lon: Double)-> Void {
        let url = NSURL(string: "http://zipbikes.co/core/lock/")!
        
        let postString: NSString = "user_id=\(userId)&bike_id=\(bikeID)&lat=\(lat)&lon=\(lon)"
        let postData: NSData = postString.dataUsingEncoding(NSASCIIStringEncoding)!
        let postLength: NSString = String(postData.length)
        NSLog("PostData: %@", postString);
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = session.dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print("lock json: ")
            print(json)
            print("\n\n\n")
            
            if let success = json["success"] as? Bool {
                if success {
                    let key = json["key"] as! NSString
                    // TODO successful lock handler
                    // self.mapController.lockSuccess(bikeID)
                    
                } else {
                    let error = json["error"] as! NSString
                    print(error)
                    // TODO error handling: uncomment below once it's implemented
                    // self.mapController.lockBikeError(bikeID, error)
                }
            } else {
                print("no \"success\" field in response from server")
            }
        }
        dataTask.resume()
    }
}