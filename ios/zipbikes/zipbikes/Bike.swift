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
    var price: Float
    var rating: Float
    var id: Int
    
    init(id: Int, title: String, coordinate: CLLocationCoordinate2D, price: Float, rating: Float){
        self.title = title
        self.coordinate = coordinate
        self.price = price
        self.rating = rating
        self.id = id
    }
    
    func ratingString() -> String {
        return "Rating: " + String(self.rating) + " out of 5"
    }
    func priceString() -> String {
        return "Price per day: $" + String(self.price)
    }
    func propertiesString() -> String {
        var propertiesString = self.ratingString() + "\n"
        propertiesString += self.priceString() + "\n"
        return propertiesString
    }
    
    func infoString() -> String {
        return self.title! + "\n" + self.propertiesString()
    }
}