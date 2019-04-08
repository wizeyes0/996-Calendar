//
//  SettingViewController.swift
//  ICU996
//
//  Created by Harry Duan on 2019/3/28.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import MessageUI
import DeviceKit
import SwiftMessages

class SettingViewController: UIViewController {
    
    private lazy var dataSource: Array = {
        return [
            [
                ["title": "薪资修改","icon":"money"],
            ],
            [
                ["title": "隐私条例","icon":"privacy"],
                ["title": "分享996日历","icon":"share"],
                //["title": "意见反馈","icon":"feedback"],
                ["title": "关于我们","icon":"aboutus"]
            ],
            [
                ["title": "Sepicat","icon":"Sepicat","desc":"最棒的GitHub三方客户端","appId":"1355383210"],
                ["title": "宠物星球","icon":"petplanet","desc":"分享萌宠学习养宠知识","appId":"1439448960"],
                ["title": "小时钟","icon":"littleClock","desc":"全屏数字翻页时钟","appId":"1455066494"],
                ["title": "iSystant Pro","icon":"iSystant","desc":"轻松查看手机硬件信息","appId":"1441902045"],
                ["title": "Pugword","icon":"pugword","desc":"好看的密码保险箱","appId":"1307617053"],
                ["title": "寻色","icon":"colorcapture","desc":"写给大家用的配色APP","appId":"1439521846"],
                ["title": "番茄清单","icon":"fanqieqingdan","desc":"随时随地记录，解放你的大脑","appId":"1150993112"]
            ]
        ]
    }()
    private lazy var salaryPopView: IcuSetSalaryPopView = {
        let p = IcuSetSalaryPopView()
        return p
    }()
    
    private lazy var headerTitle: Array = {
        return ["功能","关于","965的独立开发作品"]
    }()
    
    // 懒加载TableView
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "OurAppCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "ourAppCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        tableView.backgroundColor = UIColor(red: 247, green: 247, blue: 247)
        let leftBtn = UIBarButtonItem(image: UIImage(named: "close"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem = leftBtn
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 70
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ourAppCell") as! OurAppCell
            let sectionArray = dataSource[indexPath.section]
            let dict: [String: String] = sectionArray[indexPath.row]
            
            cell.setInfo(dict)
            return cell
        }else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            }
            
            let sectionArray = dataSource[indexPath.section]
            let dict: [String: String] = sectionArray[indexPath.row]
            
            cell!.selectionStyle = .none
            cell!.textLabel?.text = dict["title"]
            cell!.imageView?.image = UIImage(named: dict["icon"]!)
            cell!.accessoryType = .none
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightText
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 20, y: 20, width: 200, height: 20)
        headerLabel.text = headerTitle[section]
        headerLabel.textColor = UIColor.lightGray
        headerLabel.font = UIFont.icuFont(.regular, size: 13)
        view.addSubview(headerLabel)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sectionArray = dataSource[indexPath.section]
        let dict: [String: String] = sectionArray[indexPath.row]
        
        switch indexPath.section {
        case 0:
            IcuSetSalaryPopView.show()
        case 1:
            if (indexPath.row == 0) {
                let privacyVc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PrivacyViewController")
                navigationController?.pushViewController(privacyVc, animated: true)
            } else if (indexPath.row == 1) {
                shareApp()
            }  else if (indexPath.row == 2) {
                //
                let feedbackVc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ICUFeedbackViewController")
                navigationController?.pushViewController(feedbackVc, animated: true)
            }
        case 2:
            openApp(dict["appId"]!)
        default:
            print(indexPath.row)
        }
    }
 
}

extension SettingViewController {
    func shareApp() {
        var items = Array<Any>()
        items.append("ICU日历 - 注意身体别再996啦")
        items.append(UIImage(named: "logo")!)
        items.append(URL(string: "itms-apps://itunes.apple.com/app/id"+"1458273919")!)
        let shareVc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(shareVc, animated: true, completion: nil)
    }
    
    func openApp(_ appId:String) {
        let urlString = "itms-apps://itunes.apple.com/app/id\(appId)";//替换为对应的APPID
        let url = URL(string: urlString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
