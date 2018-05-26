//
//  LandingPageViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import UIKit
import CoreLocation

class LandingPageViewController: UIViewController {

    enum SegueId {
        static let toiletsSegue = "toiletsSegue"
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var establishmentsTableView: UITableView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl!
    
    let establishments: [String] = ["SM Megamall", "Makati Stock Exchange", "A VERY VERY VERY VERY VERY VERY LONG TEXT"]
    
    // MARK: - Properties for Location Handling
    var locationManager: CLLocationManager!
    
    // MARK: - Action
    
    
    @IBAction func findWashroomsButtonAction(_ sender: Any) {
        activityIndicator.isHidden = false
        locationManager.requestLocation()
    }
    
    func refreshControlAction(_ sender: UIRefreshControl) {
        sender.endRefreshing()
    }
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initLocationManager()
        initUi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        overlayView.isHidden = false
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
    }
   
    func initUi() {
        initNavigationItem()
        initSearchBar()
        initEstablishmentsTableView()
    }
    
    func initNavigationItem() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo-textual-purple"))
    }
    
    func initSearchBar() {
        searchBar.delegate = self
    }
    
    func initEstablishmentsTableView() {

        refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        establishmentsTableView.addSubview(refreshControl)
        
        establishmentsTableView.delegate = self
        establishmentsTableView.dataSource = self
        
        let nib = UINib(nibName: LandingPageTableViewCell.identifier, bundle: nil)
        establishmentsTableView.register(nib, forCellReuseIdentifier: LandingPageTableViewCell.identifier)
        
        establishmentsTableView.separatorStyle = .none
    }

}

extension LandingPageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

extension LandingPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueId.toiletsSegue, sender: self)
    }
    
}

extension LandingPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return establishments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LandingPageTableViewCell.identifier) as! LandingPageTableViewCell
        cell.establishmentNameLabel.text = establishments[indexPath.row]
        return cell
    }
    
}

// Location Stuff:
extension LandingPageViewController: CLLocationManagerDelegate {

    func taskWhenLocationIsAvailable(_ location: CLLocation) {
        print(location.coordinate)
        performSegue(withIdentifier: SegueId.toiletsSegue, sender: self)
    }
    
    func taskWhenLocationIsNull() {
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 0.0
        }) { (completed) in
            self.overlayView.isHidden = true
            self.overlayView.alpha = 1.0
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        activityIndicator.isHidden = true
        
        let forceFail = true
        
        if let location = locations.first, !forceFail {
            taskWhenLocationIsAvailable(location)
        } else {
            taskWhenLocationIsNull()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        activityIndicator.isHidden = true
    }
    
}
