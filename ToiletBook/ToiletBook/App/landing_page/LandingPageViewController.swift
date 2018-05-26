//
//  LandingPageViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {

    @IBOutlet weak var establishmentsTableView: UITableView!
    
    let establishments: [String] = ["SM Megamall", "Makati Stock Exchange", "A VERY VERY VERY VERY VERY VERY LONG TEXT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUi()
    }
   
    func initUi() {
        initNavigationItem()
        initEstablishmentsTableView()
    }
    
    func initNavigationItem() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo-textual-purple"))
    }
    
    func initEstablishmentsTableView() {
        establishmentsTableView.delegate = self
        establishmentsTableView.dataSource = self
        
        let nib = UINib(nibName: LandingPageTableViewCell.identifier, bundle: nil)
        establishmentsTableView.register(nib, forCellReuseIdentifier: LandingPageTableViewCell.identifier)
        
        establishmentsTableView.separatorStyle = .none
    }
    
    func searchButtonAction(_ sender: Any) {
        
    }

}

extension LandingPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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
