//
//  EventsController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit

class EventsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let locationName = ["Hawaii Resort", "Mountain Expedition", "Scuba Diving", "Hawaii Resort", "Mountain Expedition", "Scuba Diving"]
    let locationImage = [UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "image3"), UIImage(named: "image4"), UIImage(named: "image5"), UIImage(named: "image6")]
    let locationDescription = ["A beautiful beach resort off the coast of Hawaii", "An exhilarating mountain adventure in Yosemite National Park", "An amazing deep sea exploration event in the Gulf of Mexico", "A beautiful beach resort off the coast of Hawaii", "An exhilarating mountain adventure in Yosemite National Park", "An amazing deep sea exploration event in the Gulf of Mexico"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.locationName.text = locationName[indexPath.row]
        cell.locationDescription.text = locationDescription[indexPath.row]
        cell.locationImage.image = locationImage[indexPath.row]
        return cell
    }
    
}
