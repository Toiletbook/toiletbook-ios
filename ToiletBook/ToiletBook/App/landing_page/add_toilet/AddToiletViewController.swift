//
//  AddToiletViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/27/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import UIKit

class AddToiletViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo-textual-purple"))// #imageLiteral(resourceName: "logo-textual-purple")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitHandler(_ sender: Any) {
        let alert = UIAlertController(title: "ToiletBook", message: "Nice! Your application is now pending!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yay", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
