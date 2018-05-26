//
//  ToiletsViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import UIKit

class ToiletsViewController: UIViewController {

    @IBOutlet weak var toiletsTableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var toilets: [Toilet] = [Toilet(rating: 4.5, isTopThree: true), Toilet(rating: 3.0, isTopThree: true), Toilet(rating: 2.5, isTopThree: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUi()
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension ToiletsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toilets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToiletTableViewCell.identifier) as! ToiletTableViewCell
        let toilet = toilets[indexPath.row]
        cell.starView.setRating(toilet.rating, inTopThree: toilet.isTopThree)
        return cell
    }
    
}
