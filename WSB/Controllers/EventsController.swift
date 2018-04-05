//
//  EventsController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit
import Matisse

class EventsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let eventTitle = ["Hawaii Resort", "Mountain Expedition", "Scuba Diving", "Hawaii Resort", "Mountain Expedition", "Scuba Diving"]
    let eventTerm: String = "30 marca w godzinach 20:00 - 23:30"
    let eventImage = ["https://www.planwallpaper.com/static/images/canberra_hero_image_JiMVvYU.jpg","https://www.planwallpaper.com/static/images/9-credit-1.jpg","https://www.planwallpaper.com/static/images/6F0CE738-6419-4CF4-8E8878246C2D2569.jpg","https://www.planwallpaper.com/static/images/offset_WaterHouseMarineImages_62652-2-660x440.jpg","https://www.planwallpaper.com/static/images/6775415-beautiful-images.jpg","https://www.planwallpaper.com/static/images/Child-Girl-with-Sunflowers-Images.jpg"]
    let eventDescription = ["A beautiful beach resort off the coast of Hawaii", "An exhilarating mountain adventure in Yosemite National Park", "An amazing deep sea exploration event in the Gulf of Mexico", "A beautiful beach resort off the coast of Hawaii", "An exhilarating mountain adventure in Yosemite National Park", "An amazing deep sea exploration event in the Gulf of Mexico"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventImage.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.eventImage.round(corners: .allCorners, radius: 10)
        Matisse.load(URL.init(string: eventImage[indexPath.row])!)
            .showIn(cell.eventImage)
        
        
        cell.eventTitle.text = eventTitle[indexPath.row]
        cell.eventTerm.text = eventTerm
        cell.eventDescription.text = eventDescription[indexPath.row]
        return cell
        
    }
    
    
    
    
}
