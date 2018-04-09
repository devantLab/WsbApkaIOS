//
//  HomeController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit
import ForecastIO

class HomeController: UIViewController {

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
    
    @IBOutlet weak var expandableViewConstraint: NSLayoutConstraint!
    
    let client = DarkSkyClient(apiKey: Constants.FORECAST_API_KEY)
    let activityView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingForecast()
        view.layoutIfNeeded()
        //button cornerRadius
        alertView.round(corners: .allCorners, radius: 10)
        expandableView.round(corners: [.bottomLeft, .bottomRight], radius: 10)
        buttons.forEach { button in
            button.layer.cornerRadius = 10
        }
        
        expandableView.round(corners: [.bottomLeft, .bottomRight], radius: 10)
        
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
    func getForecast() {
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
                    self.activityView.stopAnimating()
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.weatherTemperature.text = "Wystąpił błąd podczas aktualizacji pogody"
                    self.weatherTemperature.text = ":("
                    self.activityView.stopAnimating()
                }
            }
        }
    }
    func loadingForecast() {
        activityView.center = weatherView.center
        activityView.hidesWhenStopped = true
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityView.startAnimating()
    }
    
}

