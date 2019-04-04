//
//  PrivacyViewController.swift
//  ICU996
//
//  Created by HanLiu on 2019/3/31.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func close() {
//        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }

}
