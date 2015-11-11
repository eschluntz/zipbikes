//
//  Bike.swift
//  zipbikes
//
//  Created by Devvret Rishi on 11/9/15.
//  Copyright © 2015 Devvret Rishi. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class Bike: NSObject, MKAnnotation{
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var price: Float
    var rating: Int
    
    init(title:String, coordinate: CLLocationCoordinate2D, info:String, price: Float, rating:Int){
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.price = price
        self.rating = rating
    }
}