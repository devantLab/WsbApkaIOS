//
//  EventDetailController.swift
//  WSB
//
//  Created by apple on 13.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import SDWebImage
import Firebase

class EventDetailController: UIViewController {
    var eventId: Int?
    var eventTitle: String?
    var eventDescription: String?
    var eventDate: String?
    var eventTime: String?
    var eventCity: String?
    var eventStreet: String?
    var eventImageURL: String?
    //Coordinate
    var coordinates = [String: Double]()
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var streetLabel: UILabel!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContent()
        loadImage()
        loadMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func loadImage() {
        imageView.sd_setImage(with: URL(string: eventImageURL!), placeholderImage: UIImage(named: "placeholder.png"))

    }
    private func setContent() {
        titleLabel.text = eventTitle
        dateLabel.text = eventDate
        timeLabel.text = eventTime
        cityLabel.text = eventCity
        streetLabel.text = eventStreet
    }
    private func loadMap() {
        let initialLocation: CLLocation = CLLocation(latitude: coordinates["latitude"]!, longitude: coordinates["longitude"]!)
        centerMapOnLocation(location: initialLocation)
        let artwork = PlaceMarker(title: eventTitle ?? "",
                              locationName: "\(String(describing: eventCity)), \(String(describing: eventStreet))",
            coordinate: CLLocationCoordinate2D(latitude: initialLocation.coordinate.latitude, longitude: initialLocation.coordinate.longitude))
        mapView.addAnnotation(artwork)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
