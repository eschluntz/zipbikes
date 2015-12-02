//
//  API.swift
//  zipbikes
//
//  Created by Michelle Deng on 12/1/15.
//  Copyright © 2015 Devvret Rishi. All rights reserved.
//

import Foundation

class API {
    
    let session = NSURLSession.sharedSession()
    
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
            print(json)
            
            //for
        }
        dataTask.resume()
        
        return nil
    }
}