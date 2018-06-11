//
//  EventDetailController.swift
//  WSB
//
//  Created by apple on 13.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage
import Firebase
import LocalizationKit

class EventDetailController: UIViewController {
    
    var event: Event?
    var coordinates = [String: Double]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
        loadImage()
        loadMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func loadImage() {
        imageView.sd_setImage(with: URL(string: (event?.eventImage)!), placeholderImage: UIImage(named: "placeholder.png"))

    }
    
    fileprivate func setContent() {
        titleLabel.text = event?.eventTitle
        let calendar = Calendar.current
        let date = event?.eventDate
        let year = calendar.component(.year, from: date!)
        let month = calendar.component(.month, from: date!)
        let day = calendar.component(.day, from: date!)
        dateLabel.text = "\(day) \(MonthConverter.monthName(month: month, language: Localization.language!.key)) \(year)"
        timeLabel.text = (event?.eventTimeEnd.elementsEqual("0"))! ? "\(event?.eventTimeStart ?? "")" : "\(event?.eventTimeStart ?? "") - \(event?.eventTimeEnd ?? "")"
        cityLabel.text = event?.eventCity
        streetLabel.text = event?.eventStreet
        descriptionTextView.text = event?.eventDescription
        //description text resizing to content
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = true
        descriptionTextView.sizeToFit()
        descriptionTextView.isScrollEnabled = false
    }
    
    fileprivate func loadMap(){
        let location = MapManager.initialLocation(coordinates: coordinates)
        mapView.addAnnotation(MapManager.annotation(coordinates: coordinates, eventTitle: event?.eventTitle ?? "", eventCity: event?.eventCity ?? "", eventStreet: event?.eventStreet ?? ""))
        mapView.setRegion(MapManager.coordinateRegion(location: location), animated: true)
    }
    
}
