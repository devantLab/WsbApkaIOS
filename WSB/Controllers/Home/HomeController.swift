//
//  HomeController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit
import ForecastIO
import Firebase
import LocalizationKit

class HomeController: UIViewController, LanguageManager {

   
    @IBOutlet weak var expandableView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var alertArrow: UIImageView!
    @IBOutlet weak var alertButton: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var expandableViewConstraint: NSLayoutConstraint!
    
    let client = DarkSkyClient(apiKey: Constants.FORECAST_API_KEY)
    var weatherDescriptionText = Localization.get("PogodaBlad", alternate: "Wystąpił błąd podczas aktualizacji pogody")
    var weatherTemperatureText = ":("
    let loadingText = Localization.get("Ladowanie", alternate: "Loading");
    private let rootRef = Database.database().reference()
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        setLanguage()
        //disabling the button until the data is properly loaded
        buttons[1].isEnabled = false
        getEvent()
        Localization.setLanguage(Language.russian.rawValue)
        //button cornerRadius
        alertView.round(corners: .allCorners, radius: 10)
        expandableView.round(corners: [.bottomLeft, .bottomRight], radius: 10)
        buttons.forEach { button in
            button.layer.cornerRadius = 10
        }
        
        expandableView.round(corners: [.bottomLeft, .bottomRight], radius: 10)
        self.buttons[2].isEnabled = false
        self.view.setNeedsDisplay()
        //hiding the expandableView
        self.expandableViewConstraint.constant = 0
        
    }
    override func viewDidAppear(_ animated: Bool) {
        getForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func weatherButtonClick(_ sender: Any) {
        self.buttons[0].shake()
        
    }
    @IBAction func alertButtonClick(_ sender: Any) {
        expandAlertButton()
    }
    
    
    func expandAlertButton() {
        view.layoutIfNeeded()
        

        let height: CGFloat = (self.expandableViewConstraint.constant == 0) ? 150 : 0
        let expanded: Bool = (height == 0) ? false : true
        if expanded == true {
            alertView.round(corners: [.topRight, .topLeft], radius: 10)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.expandableViewConstraint.constant = height
            self.alertArrow.transform = self.alertArrow.transform.rotated(by: CGFloat(Double.pi))
            
            self.view.layoutIfNeeded()
        }, completion:{ Bool in
            if expanded == false {
            self.alertView.round(corners: .allCorners, radius: 10)
            }
            
        })
    }
    private func getForecast() {
        client.units = .si
        client.language = .polish
        let lat = 54.372158
        let lon = 18.638306
        client.getForecast(latitude: lat, longitude: lon) { result in
            switch result {
            case .success(let currentForecast, _):
                DispatchQueue.main.async {
                    self.weatherDescription.text = currentForecast.currently?.summary
                    let temperature: Int = Int((currentForecast.currently?.temperature)!)
                    self.weatherTemperature.text = String(temperature) + "°"
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.weatherDescription.text = self.weatherDescriptionText
                    self.weatherTemperature.text = self.weatherTemperatureText
                    
                }
            }
        }
    }
    private func getEvent() {
        let eventsRef = rootRef.child("Events").queryLimited(toFirst: 1)
        eventsRef.observe(DataEventType.childAdded, with: {(snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let event: Event = EventDataParser.parse(dict: dict)
                self.event = event
                DispatchQueue.main.async {
                    self.eventTitle.text = event.eventTitle
                    self.eventDescription.text = event.eventDescription
                    // buttons[2] -> Event Button
                    self.buttons[1].isEnabled = true
                }
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EventDetailController {
            let event = self.event
            let calendar = Calendar.current
            let date = event?.eventDate
            let year = calendar.component(.year, from: date!)
            let month = calendar.component(.month, from: date!)
            let day = calendar.component(.day, from: date!)
            destination.eventId = event?.eventId
            destination.eventTitle = event?.eventTitle
            destination.eventDate = "\(day) \(MonthConverter.monthName(month: month, language: "pl")) \(year)"
            let time: String = (event!.eventTimeEnd.elementsEqual("0")) ? "\(event!.eventTimeStart)" : "\(event!.eventTimeStart) - \(event!.eventTimeEnd)"
            destination.eventTime = "\(time)"
            destination.eventCity = event?.eventCity
            destination.eventStreet = event?.eventStreet
            destination.eventImageURL = event?.eventImage
            destination.eventDescription = event?.eventDescription
            destination.coordinates = ["latitude": event?.eventLatitude, "longitude": event?.eventLongitude] as! [String : Double]
            
        }
    }
   
    @IBAction func openSideMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    //LanguageManager Protocol setLanguage() method implementation
    func setLanguage(){
        weatherDescription.text = loadingText
        eventDescription.text = loadingText
    }
}

