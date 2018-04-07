//
//  EventsController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit
import Matisse
import RealmSwift

class EventsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var realm: Realm!
    var notificationToken: NotificationToken?
    var items = List<Event>()
    let eventTitle = ["Hawaii Resort", "Mountain Expedition", "Scuba Diving", "Hawaii Resort", "Mountain Expedition", "Scuba Diving"]
    let eventTerm: String = "30 marca w godzinach 20:00 - 23:30"
    let eventImage = ["https://www.planwallpaper.com/static/images/canberra_hero_image_JiMVvYU.jpg","https://www.planwallpaper.com/static/images/9-credit-1.jpg","https://www.planwallpaper.com/static/images/6F0CE738-6419-4CF4-8E8878246C2D2569.jpg","https://www.planwallpaper.com/static/images/offset_WaterHouseMarineImages_62652-2-660x440.jpg","https://www.planwallpaper.com/static/images/6775415-beautiful-images.jpg","https://www.planwallpaper.com/static/images/Child-Girl-with-Sunflowers-Images.jpg"]
    let eventDescription = ["A beautiful beach resort off the coast of Hawaii", "An exhilarating mountain adventure in Yosemite National Park", "An amazing deep sea exploration event in the Gulf of Mexico", "A beautiful beach resort off the coast of Hawaii", "An exhilarating mountain adventure in Yosemite National Park", "An amazing deep sea exploration event in the Gulf of Mexico"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupRealm()
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let item = items[indexPath.row]
        cell.eventTitle?.text = item.eventTitle
        cell.eventDescription?.text = item.eventDescription
        Matisse.load(URL(string: item.eventImage)!).showIn(cell.eventImage)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.eventImage.round(corners: .allCorners, radius: 10)
        cell.dateView.round(corners: .allCorners, radius: 10)
        return cell
        
    }
    func setupRealm() {
        // ... existing function ...
        SyncUser.logIn(with: .usernamePassword(username: Constants.USERNAME, password: Constants.PASSWORD, register: false), server: Constants.AUTH_URL) { user, error in
            guard let user = user else {
                fatalError(String(describing: error))
            }
            
            DispatchQueue.main.async {
                // Open Realm
                let configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user, realmURL: Constants.REALM_URL)
                )
                self.realm = try! Realm(configuration: configuration)
                
                // Show initial tasks
                func loadList() {
                    let elements = self.realm.objects(Event.self).elements
                    elements.forEach({
                        event in
                        self.items.append(event)
                    })
                    self.tableView.reloadData()
                }
                func updateList() {
                    
                    if self.items.realm == nil, let list = self.realm.objects(Event.self).last {
                        self.items.append(list)
                    }
                    self.tableView.reloadData()
                }
                loadList()
                
                // Notify us when Realm changes
                self.notificationToken = self.realm.observe { _,_ in
                    updateList()
                    
                }
            }
        }
    }
    
    
    
    
}
