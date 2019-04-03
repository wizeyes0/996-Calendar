//
//  OurAppCell.swift
//  ICU996
//
//  Created by HanLiu on 2019/3/31.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class OurAppCell: UITableViewCell {

    @IBOutlet var icon: UIImageView!
    @IBOutlet var appname: UILabel!
    @IBOutlet var appDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        icon.layer.masksToBounds = false
        icon.layer.cornerRadius = 4
        let shadowColor = UIColor(red: 121, green: 121, blue: 121)
        icon.layer.applySketchShadow(color: shadowColor,
                                     alpha: 0.5,
                                     x: 0,
                                     y: 2,
                                     blur: 10,
                                     spread: 0)
    }

    func setInfo(_ dict: [String: String]) {
        icon.image = UIImage(named: dict["icon"]!)
        appname.text = dict["title"]
        appDesc.text = dict["desc"]
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
