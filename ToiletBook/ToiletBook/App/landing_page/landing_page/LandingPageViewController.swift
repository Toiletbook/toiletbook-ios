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
    
    var refreshControl: UIRefreshControl!
    
    let establishments: [String] = ["SM Megamall", "Makati Stock Exchange", "A VERY VERY VERY VERY VERY VERY LONG TEXT"]
    
    // MARK: - Properties for Location Handling
    var locationManager: CLLocationManager!
    
    // MARK: - Action
    
    func searchButtonAction(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    func refreshControlAction(_ sender: UIRefreshControl) {
        sender.endRefreshing()
    }

    func ultimateButtonAction(_sender: Any) {
        locationManager.requestLocation()
    }
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initLocationManager()
        initUi()
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
        initUltimateButtonOverlay()
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
    
    // MARK: - Ultimate View
    
    var ultView: UIView!
    var ultButton: UIButton!
    
    func initUltimateButtonOverlay() {
        
        ultView = UIView(frame: UIScreen.main.bounds)
        ultView.backgroundColor = UIColor.white
        
        ultButton = UIButton(type: .custom)
        ultButton.addTarget(self, action: #selector(ultimateButtonAction(_sender:)), for: .touchUpInside)
        
        ultButton.backgroundColor = Colors.main.value
        
        ultButton.setTitle("FIND NEARBY WASHROOMS", for: .normal)
        ultButton.titleLabel?.textAlignment = .center
        ultButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        ultButton.setTitleColor(UIColor.white, for: .normal)
        ultButton.setTitleColor(UIColor.white.withAlphaComponent(0.50), for: .highlighted)
        
        ultView.addSubview(ultButton)
        ultButton.translatesAutoresizingMaskIntoConstraints = false
        ultButton.centerXAnchor.constraint(equalTo: ultView.centerXAnchor).isActive = true
        ultButton.centerYAnchor.constraint(equalTo: ultView.centerYAnchor).isActive = true
        ultButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        ultButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.85).isActive = true
        
        UIApplication.shared.keyWindow?.addSubview(ultView)
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        ultView.removeFromSuperview()
        if let location = locations.first {
            print(location.coordinate)
            // do a query here
            performSegue(withIdentifier: SegueId.toiletsSegue, sender: self)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        ultView.removeFromSuperview()
    }
    
}
