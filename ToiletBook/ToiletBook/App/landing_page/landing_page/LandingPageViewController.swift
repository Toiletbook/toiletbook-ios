//
//  LandingPageViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import Alamofire
import CoreLocation
import UIKit

class LandingPageViewController: UIViewController {

    enum SegueId {
        static let toiletsSegue = "toiletsSegue"
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var establishmentsTableView: UITableView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var findNearbyWashroomsButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var becomeAParterButton: UIButton!
    
    var refreshControl: UIRefreshControl!
    
    var establishmentId: String?
    var establishments: [Establishment] = []
    
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
    
    func titleViewTapped(_ recognizer: UITapGestureRecognizer) {
        establishmentId = nil
        performSegue(withIdentifier: SegueId.toiletsSegue, sender: self)
    }
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initLocationManager()
        initUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.overlayView.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 1.0
        }) { (completed) in
        }
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
        findNearbyWashroomsButton.layer.cornerRadius = findNearbyWashroomsButton.frame.height/2
        
        becomeAParterButton.layer.borderColor = UIColor.white.cgColor
        becomeAParterButton.layer.borderWidth = 2.0
        becomeAParterButton.layer.cornerRadius = becomeAParterButton.frame.height/2
    }
    
    func initNavigationItem() {
        let v = UIImageView(image: #imageLiteral(resourceName: "logo-textual-purple"))
        navigationItem.titleView = v
        
        let gestureRecoginzer = UITapGestureRecognizer(target: self, action: #selector(titleViewTapped(_:)))
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(gestureRecoginzer)
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

extension LandingPageViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.toiletsSegue, let dest = segue.destination as? ToiletsViewController {
            dest.establishmentId = establishmentId
        }
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
        establishmentId = String(establishments[indexPath.row].id)
        performSegue(withIdentifier: SegueId.toiletsSegue, sender: self)
    }
    
}

extension LandingPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return establishments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LandingPageTableViewCell.identifier) as! LandingPageTableViewCell
        let establishment = establishments[indexPath.row]
        cell.establishmentNameLabel.text = establishment.name
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
        
        NetworkManager.instance.requestArray(endpoint: NetworkManager.Endpoints.establishments) { (resp: DataResponse<[Establishment]>) in
            DispatchQueue.main.async {
                self.establishments = resp.result.value!
                self.establishmentsTableView.reloadData()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.overlayView.alpha = 0.0
                }) { (completed) in
                    self.overlayView.isHidden = true
                    self.activityIndicator.isHidden = true
                }
            }
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
