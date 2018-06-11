//
//  Map.swift
//  WSB
//
//  Created by apple on 10.06.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation
import MapKit

class MapManager {
    
    static func initialLocation(coordinates: [String : Double]) -> CLLocation {
        return CLLocation(latitude: coordinates["latitude"]!, longitude: coordinates["longitude"]!)
    }
    
    static func annotation(coordinates: [String : Double], eventTitle: String, eventCity: String, eventStreet: String) -> PlaceMarker {
        let initialLocation: CLLocation = CLLocation(latitude: coordinates["latitude"]!, longitude: coordinates["longitude"]!)
        return PlaceMarker(title: eventTitle,
                                  locationName: "\(eventCity), \(eventStreet)",
            coordinate: CLLocationCoordinate2D(latitude: initialLocation.coordinate.latitude, longitude: initialLocation.coordinate.longitude))
    }
    
    static func coordinateRegion(location: CLLocation) -> MKCoordinateRegion{
        let regionRadius: CLLocationDistance = 1000
        return MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
    }
}
