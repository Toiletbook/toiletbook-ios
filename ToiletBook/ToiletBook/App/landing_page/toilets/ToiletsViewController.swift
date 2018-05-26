//
//  ToiletsViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import Alamofire
import UIKit

class ToiletsViewController: UIViewController {

    enum SegueId {
        static let toiletDetailSegue = "toiletDetailSegue"
    }
    
    @IBOutlet weak var toiletsTableView: UITableView!
    
    var establishmentId: String!
    var refreshControl: UIRefreshControl!
    
    var washrooms: [Washroom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUi()
        
        print(establishmentId)
        
        NetworkManager.instance.requestArray(endpoint: NetworkManager.Endpoints.getEstablishmentWashrooms(establishmentId: establishmentId)) { (resp: DataResponse<[Washroom]>) in
            
            DispatchQueue.main.async {
                self.washrooms = resp.result.value!
                print(self.washrooms)
                self.toiletsTableView.reloadData()
            }
            
        }
        
    }
    
    func initUi() {
        initNavigationItem()
        initToiletsTableView()
    }
    
    func initToiletsTableView() {
        refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        toiletsTableView.addSubview(refreshControl)
        
        toiletsTableView.delegate = self
        toiletsTableView.dataSource = self
        
        let nib = UINib(nibName: ToiletTableViewCell.identifier, bundle: nil)
        toiletsTableView.register(nib, forCellReuseIdentifier: ToiletTableViewCell.identifier)
        
        toiletsTableView.separatorStyle = .none
    }
    
    func initNavigationItem() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo-textual-purple"))
    }
    
    func refreshControlAction(_ sender: UIRefreshControl) {
        sender.endRefreshing()
    }

}

extension ToiletsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SegueId.toiletDetailSegue, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension ToiletsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return washrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToiletTableViewCell.identifier) as! ToiletTableViewCell
        let washroom = washrooms[indexPath.row]
        let isTopThree = indexPath.row > 2
        cell.invertColors(isTopThree)
        cell.name.text = washroom.name
        cell.locationDescription.text = washroom.location_description
        
        cell.areaNameLabel.text = washroom.area_name
        print(washroom.area_name)
        cell.establishmentNameLabel.text = washroom.establishment_name
        
        cell.starView.setRating(washroom.general_rating, inTopThree: !isTopThree)
        
        return cell
    }
    
}
