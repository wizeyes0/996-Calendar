//
//  ICUFeedbackViewController.swift
//  ICU996
//
//  Created by lvl on 2019/3/30.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import MessageUI
import DeviceKit

class ICUFeedbackViewController: UIViewController  {
    
    let appVersion = UIDevice.current.appVersion
    
    let appBuild = UIDevice.current.appBuild
    
    var appVersionBuild:String{
        get {
            return "Version:\(appVersion)(\(appBuild))"
        }
    }
    private lazy var weibos: Array = {
        return ["2642643770",//-一楠
                "desgard",//冬瓜
                "1619592223",//-寒流
                "6255309638",//-霖
                "2158505911",//-油条
                "6279074646",//-振华
                "1929625262",//-世杰
                "2813939663",//-高惠宇
                "234399610",//A.xxx
        ]
    }()
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = appVersionBuild
        feedbackButton.setGradientShadow()
        rateButton.setGradientShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func closeButtonClickedAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func feedbackButtonClickedAction(_ sender: Any) {
        self.sendMailInApp()
    }
    
    @IBAction func rateUSButtonClickedAction(_ sender: Any) {
        let appID = "xxxxx"
        let urlString = "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review";//替换为对应的APPID
        let url = URL(string: urlString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func sendMailInApp()
    {
        if MFMailComposeViewController.canSendMail() {
            //注意这个实例要写在if block里，否则无法发送邮件时会出现两次提示弹窗（一次是系统的）
            let mailComposeViewController = configuredMailComposeViewController()
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }

    @IBAction func openWeibo(_ sender:UIButton!) {
        
        var weiboId = "1619592223"
        weiboId = weibos[sender.tag]
        
        let url = URL(string: "https://weibo.com/\(weiboId)?is_all=1")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly:"996"]) { success in
                print(success)
            }
        }
    }
}

extension ICUFeedbackViewController {
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["<你的邮箱地址>"])
        mailComposeVC.setSubject("关于996日历的反馈建议")
        mailComposeVC.setMessageBody(self.messageBody(), isHTML: false)
        
        return mailComposeVC
    }
    
    func messageBody() -> String {
        let systemVersion = UIDevice.current.systemVersion
        let deviceModel = Device()
        return "\n\n\n\n\n\n系统版本：\(systemVersion)\n设备型号：\(deviceModel)\nAPP版本：\(self.appVersionBuild)"
    }
    
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "无法发送邮件", message: "您的设备尚未设置邮箱，请在“邮件”应用中设置后再尝试发送。", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true){}
        
    }
}

extension ICUFeedbackViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
            case .cancelled:
                print("取消发送")
            case .sent:
                print("发送成功")
            default:
                break
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
