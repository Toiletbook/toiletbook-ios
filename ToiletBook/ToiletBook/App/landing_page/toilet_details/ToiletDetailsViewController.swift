//
//  ToiletDetailsViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import MapKit
import UIKit
import UserNotifications

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Integer{
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

class ToiletDetailsViewController: UIViewController {

    var washroom: Washroom!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stars: StarView!
    @IBOutlet weak var locationPin: UIImageView!
    @IBOutlet weak var locationDescription: UILabel!
    @IBOutlet weak var areaPill: UIView!
    @IBOutlet weak var areaName: UILabel!
    @IBOutlet weak var establishmentPill: UIView!
    @IBOutlet weak var establishmentName: UILabel!
    @IBOutlet weak var deeplinkButton: UIButton!
    
    @IBOutlet weak var schedPill: UIView!
    @IBOutlet weak var pricePill: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var visits: UILabel!
    
    // MARK: - Action
    
    
    @IBAction func deepLinkButtonAction(_ sender: Any) {
        let latitude: CLLocationDegrees = washroom.latitude
        let longitude: CLLocationDegrees = washroom.longitude
        
        let regionDistance:CLLocationDistance = 500
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = washroom.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUi()
    }
    
    func initUi() {
        initNavigationItem()
        
        name.text = washroom.name
        stars.setRating(washroom.general_rating, inTopThree: true, sponsored: washroom.is_sponsored.bool, whiteBg: true)
        locationPin.tintColor = Colors.dark.value
        locationDescription.text = washroom.location_description
        
        areaPill.layer.cornerRadius = areaPill.frame.height/2
        areaName.text = washroom.area_name
        
        establishmentPill.layer.cornerRadius = establishmentPill.frame.height/2
        establishmentName.text = washroom.establishment_name
        
        [schedPill, pricePill].forEach { (v) in
            v!.layer.cornerRadius = v!.frame.height/2
        }
        
        priceLabel.text = washroom.is_free.bool ? "FREE" : String("10 PHP") // washroom.entry_amount
        
        initAbout()
        dummifyRatings()
        
        visits.text = washroom.visits.formattedWithSeparator
        
        initMapKitView()
    }
    
    func initNavigationItem() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo-textual-purple"))
    }
    
    // MARK - About
    
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderIcon: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var tissuesView: UIView!
    @IBOutlet weak var bidetView: UIView!
    @IBOutlet weak var pwdView: UIView!
    @IBOutlet weak var infantView: UIView!
    @IBOutlet weak var vendorView: UIView!
    
    func initAbout() {
        
        genderIcon.image = {
            
            if washroom.gender_is_male_only.bool {
                genderLabel.text = "MALE"
                return #imageLiteral(resourceName: "atr-gender-male")
            }
            
            if washroom.gender_is_female_only.bool {
                genderLabel.text = "FEMALE"
                return #imageLiteral(resourceName: "atr-gender-female")
            }
            
            genderLabel.text = "BOTH"
            return #imageLiteral(resourceName: "atr-gender-unisex")
        }()
        
        bidetView.alpha = washroom.has_bidet.bool ? 1.0 : 0.30
        infantView.alpha = washroom.has_diaper_station.bool ? 1.0 : 0.30
        pwdView.alpha = washroom.is_pwd_friendly.bool ? 1.0 : 0.30
        tissuesView.alpha = washroom.has_tissues.bool ? 1.0 : 0.30
        vendorView.alpha = washroom.has_vending_machine.bool ? 1.0 : 0.30
        waterView.alpha = washroom.has_water.bool ? 1.0 : 0.30
        
    }
    
    // MARK: - Dummy Ratings
    
    @IBOutlet weak var cleanlinessStar: StarView!
    @IBOutlet weak var waitingTimeStar: StarView!
    @IBOutlet weak var happinessStar: StarView!
    
    func dummifyRatings() {
        
        let 😸: [Int] = washroom.washroom_attributes.map { (🐉) -> Int in
            return 🐉.average_rating
        }
        
        var n = 0
        
        [cleanlinessStar, waitingTimeStar, happinessStar].forEach { (j) in
            j!.setRating(Double(😸[0]), inTopThree: true, sponsored: washroom.is_sponsored.bool, whiteBg: true)
            n += 1
        }
    }
    
    // MARK: - Pahabol Map Kit
    
    @IBOutlet weak var mapKitView: MKMapView!
    
    func initMapKitView() {
        let latitude: CLLocationDegrees = washroom.latitude
        let longitude: CLLocationDegrees = washroom.longitude
        
        let regionDistance:CLLocationDistance = 500
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        mapKitView.showsUserLocation = true
        mapKitView.setRegion(regionSpan, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        mapKitView.addAnnotation(annotation)
    }
    
    // MARK: - Notifs
    
    func prepareNotif() {
        

        let content = UNMutableNotificationContent()
        content.title = "Hey there!"
        content.body = "Did you use the washroom in \(washroom.establishment_name!), \(washroom.name!)?"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "Test12345"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let identifier = "ToiletBook"
        
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        
        
        
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                error.localizedDescription.errorPrint()
            }
        })
        
    }
    
}
