//
//  ToiletsViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import Alamofire
import UIKit

extension Int {
    
    var bool: Bool {
        return !(self == 0)
    }
    
}

extension UIView
{
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}

class ToiletsViewController: UIViewController {

    enum SegueId {
        static let toiletDetailSegue = "toiletDetailSegue"
    }
    
    @IBOutlet weak var toiletsTableView: UITableView!
    
    var establishmentId: String?
    var refreshControl: UIRefreshControl!
    
    var currentRow: Int!
    var selectedWashroom: Washroom!
    var washrooms: [Washroom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUi()
        
        guard let id = establishmentId else {
            NetworkManager.instance.requestArray(endpoint: NetworkManager.Endpoints.getWashrooms) { (resp: DataResponse<[Washroom]>) in
                DispatchQueue.main.async {
                    self.washrooms = resp.result.value!
                    print(self.washrooms)
                    self.toiletsTableView.reloadData()
                }
            }
            return
        }
        
        NetworkManager.instance.requestArray(endpoint: NetworkManager.Endpoints.getEstablishmentWashrooms(establishmentId: id)) { (resp: DataResponse<[Washroom]>) in
            
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

extension ToiletsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueId.toiletDetailSegue, let dest = segue.destination as? ToiletDetailsViewController {
            dest.washroom = selectedWashroom
        }
    }
}

extension ToiletsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentRow = indexPath.row
        self.selectedWashroom = washrooms[indexPath.row]
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
        cell.establishmentNameLabel.text = washroom.establishment_name
        
        cell.starView.setRating(washroom.general_rating, inTopThree: isTopThree, sponsored: washroom.is_sponsored.bool, whiteBg: false)
        
        // setup attributes:
        cell.genderImageView.image = {
            
            if washroom.gender_is_male_only.bool {
                return #imageLiteral(resourceName: "atr-gender-male")
            }
            
            if washroom.gender_is_female_only.bool {
                return #imageLiteral(resourceName: "atr-gender-female")
            }
            
            return #imageLiteral(resourceName: "atr-gender-unisex")
        }()
            
        cell.paymentImageView.image = {
            
            if washroom.is_free.bool {
                return #imageLiteral(resourceName: "atr-payment-free")
            }
            
            return #imageLiteral(resourceName: "atr-payment-paid")
        }()
        
        cell.bidetImageView.alpha = washroom.has_bidet.bool ? 1.0 : 0.30
        cell.infantImageView.alpha = washroom.has_diaper_station.bool ? 1.0 : 0.30
        cell.pwdImageView.alpha = washroom.is_pwd_friendly.bool ? 1.0 : 0.30
        cell.tissueImageView.alpha = washroom.has_tissues.bool ? 1.0 : 0.30
        cell.vendorImageView.alpha = washroom.has_vending_machine.bool ? 1.0 : 0.30
        cell.waterImageView.alpha = washroom.has_water.bool ? 1.0 : 0.30
        
        
        return cell
    }
    
}
