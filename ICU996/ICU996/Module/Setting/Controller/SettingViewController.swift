//
//  SettingViewController.swift
//  ICU996
//
//  Created by Harry Duan on 2019/3/28.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    private lazy var dataSource: Array = {
        return [
            [["title": "薪资修改","icon":"menu"],
             ["title": "意见反馈","icon":"menu"]],
                
            [["title": "隐私条例","icon":"menu"],
             ["title": "推荐996闹钟","icon":"menu"],
             ["title": "关于APP","icon":"menu"],
             ["title": "相关人员","icon":"menu"]],
            
            [["title": "Sepicat","icon":"logo","desc":"最棒github客户端"],
             ["title": "寻色","icon":"logo","desc":"为你寻找最美配色"],
             ["title": "iSystant Pro","icon":"logo","desc":"排名最高系统工具"],
             ["title": "宠物星球","icon":"logo","desc":"舔宠聚集地"]]
        ]
    }()
    
    private lazy var headerTitle: Array = {
        return ["功能","关于","我们的作品"]
    }()
    
    // 懒加载TableView
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        let leftBtn = UIBarButtonItem(image: UIImage(named: "close"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem = leftBtn
        self.view.addSubview(self.tableView)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let sectionArray = dataSource[indexPath.section]
        let dict: [String: String] = sectionArray[indexPath.row]
        if indexPath.section == 2 {
            cell.detailTextLabel?.text = dict["desc"]
        }
        
        cell.selectionStyle = .none
        cell.textLabel?.text = dict["title"]
        cell.imageView?.image = UIImage(named: dict["icon"]!)
        cell.imageView?.frame = CGRect(x: 10, y: 15, width: 40, height: 40)
        cell.accessoryType = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightText
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 20, y: 20, width: 100, height: 20)
        headerLabel.text = headerTitle[section]
        headerLabel.textColor = UIColor.lightGray
        headerLabel.font = UIFont.icuFont(.regular, size: 13)
        view.addSubview(headerLabel)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    

}
