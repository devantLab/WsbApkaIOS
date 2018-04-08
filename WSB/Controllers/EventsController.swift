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
    var events = List<Event>()
    
    // MARK: PULL TO REFRESH
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = tabBarController?.tabBar.barTintColor
        refreshControl.addTarget(self, action: #selector(loadList), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupRealm()
        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let event = events[indexPath.row]
        cell.eventTitle?.text = event.eventTitle
        cell.eventDescription?.text = event.eventDescription
        Matisse.load(URL(string: event.eventImage)!).showIn(cell.eventImage)
        let date = event.eventTerm
        let calendar = Calendar.current
        //let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        cell.eventMonth.text = monthName(month: month)
        cell.eventDay.text = String(day)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.eventImage.round(corners: .allCorners, radius: 10)
        cell.dateView.round(corners: .allCorners, radius: 10)
        return cell
        
    }
    
    // MARK: LOAD EVENTS METHOD
    @objc func loadList() {
        //upcoming events at the top
        let loadedEvents = self.realm.objects(Event.self).elements.sorted(byKeyPath: "eventTerm", ascending: true)
        let tempListOfEvents = List<Event>()
        loadedEvents.forEach({
            event in
            tempListOfEvents.append(event)
        })
        self.events = tempListOfEvents
        self.tableView.reloadData()
        refresher.endRefreshing()
    }
    
    // MARK: MONTHNAME METHOD
    func monthName(month: Int) -> String {
        switch month {
        case 1:
            return "Jan."
        case 2:
            return "Feb."
        case 3:
            return "Mar."
        case 4:
            return "Apr."
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Aug."
        case 9:
            return "Sept."
        case 10:
            return "Oct."
        case 11:
            return "Nov."
        case 12:
            return "Dec."
        default:
            return "Error"
        }
    }
    
    // MARK: REALM SETUP
    func setupRealm() {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let activityView = UIActivityIndicatorView()
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityView.color = tabBarController?.tabBar.barTintColor
        activityView.startAnimating()
        
        self.view.addSubview(activityView)

        //Realm logIn
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
                self.loadList()
                self.tableView.refreshControl = self.refresher
                activityView.stopAnimating()
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                
            }
        }
    }
    
    // MARK: REALM OBSERVE (UNIMPLEMENTED)
    //                func updateList() {
    //
    //                    if self.items.realm == nil, let newEvent = self.realm.objects(Event.self).last {
    //                        self.items.insert(newEvent, at: 0)
    //                    }
    //                    self.tableView.reloadData()
    //                }
    //self.loadList()
    
    // Notify us when Realm changes
    //                self.notificationToken = self.realm.observe { _,_ in
    //                    updateList()
    //
    //                }
    
}
