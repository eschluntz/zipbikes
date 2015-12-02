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
    
    func getBikes()-> [Bike]? {
        let url = NSURL(string: "http://zipbikes.co/core/map/")!
        
        /*
        let post:NSString = "username=\(username)&password=\(password)"
        
        NSLog("PostData: %@",post);
        
        let url:NSURL = NSURL(string:"https://dipinkrishna.com/jsonlogin2.php")!
        
        let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        
        let postLength:NSString = String( postData.length )*/
        
        
        
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
                
                for var i = 0; i < bikejsons.count; i++ {
                    let bikejson = bikejsons[i]
                    
                    let lat = (bikejson["lat"] as! NSNumber).doubleValue
                    let lon = (bikejson["lon"] as! NSNumber).doubleValue
                    
                    let bike = Bike(title: "Bike " + String(i),
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
        
        return nil
    }
}