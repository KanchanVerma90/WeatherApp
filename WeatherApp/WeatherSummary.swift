//
//  WeatherSummary.swift
//  WeatherApp
//
//  Created by Kanchan Verma on 01/10/24.
//

import UIKit

class WeatherSummary: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityDesc: UILabel!
    var cellVal:[String: Any]?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateUI(){
        containerView.layer.borderColor = (UIColor.systemBlue.withAlphaComponent(0.3)).cgColor
        containerView.layer.borderWidth = 0.8
        containerView.layer.cornerRadius = 8
        self.selectionStyle = .none
    }
    func updateValues(with: LocationSearch) {
        cityName.text = with.name
        cityDesc.text = with.region + "," + with.country
    }
}
