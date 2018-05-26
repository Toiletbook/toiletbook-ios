//
//  LandingPageViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {

    enum SegueId {
        static let toiletsSegue = "toiletsSegue"
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var establishmentsTableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    let establishments: [String] = ["SM Megamall", "Makati Stock Exchange", "A VERY VERY VERY VERY VERY VERY LONG TEXT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUi()
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
    
    
    func searchButtonAction(_ sender: Any) {
    }
    
    func refreshControlAction(_ sender: UIRefreshControl) {
        sender.endRefreshing()
    }

}

extension LandingPageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

extension LandingPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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
