//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 03/10/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
     func setupActivityIndicator() {
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            self.view.addSubview(activityIndicator)
        }
}
