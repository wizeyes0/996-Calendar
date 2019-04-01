//
//  IcuPopView.swift
//  ICU996
//
//  Created by HanLiu on 2019/3/31.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import SwiftMessages

class IcuPopView: UIView {

    var confirmEvent: ((_ salaryValue:Int )->Void)?
    
    private var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "在此输入您的月薪:"
        label.font = UIFont.icuFont(.medium, size:15)
        return label
    }()
    
    private var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "输入月薪..."
        tf.borderStyle = UITextField.BorderStyle.none
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private var confirmBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("确定", for: UIControl.State.normal)
        btn.setGradientShadow()
        btn.addTarget(self, action: #selector(hideMe), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "我们承诺：不会上传一切隐私敏感信息，所有隐私敏感的操作均未涉及到网络连接，请放心使用。"
        label.numberOfLines = 0
        label.font = UIFont.icuFont(.regular, size:11)
        label.textColor = UIColor(red: 181, green: 181, blue: 181)
        return label
    }()
    
//    lazy  var config:SwiftMessages.Config = {
//        var con = SwiftMessages.Config()
//        con.presentationStyle = .center
//        con.duration = .forever
//        con.dimMode = .blur(style: UIBlurEffect.Style.dark, alpha: 0.8, interactive: true)
//        con.presentationContext = .window(windowLevel: .statusBar)
//        return con
//    }()
//    
//    func show() {
//        SwiftMessages.show(config:self.config, view: self.backView)
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialViews()
        initialLayouts()
        textField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialViews() {
        addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(textField)
        backView.addSubview(confirmBtn)
        backView.addSubview(descLabel)
    }
    
    private func initialLayouts() {
        backView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview()
            //maker.height.width.equalTo(335)
            maker.left.equalTo(20)
            maker.right.equalTo(-20)
        }
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(29)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(135)
            maker.height.equalTo(21)
        }
        
        textField.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(25)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(100)
            maker.height.equalTo(29)
        }
        
        confirmBtn.snp.makeConstraints { (maker) in
            maker.top.equalTo(textField.snp.bottom).offset(32)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(200)
            maker.height.equalTo(40)
        }
        
        descLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview().offset(-30)
            maker.left.equalToSuperview().offset(20)
            maker.right.equalToSuperview().offset(-20)
            maker.height.equalTo(34)
        }
    }
    
    @objc func hideMe() {
        guard !(textField.text?.isEmpty)! else {
            return
        }
        if let event = self.confirmEvent{
            event(Int(textField.text!)!)
        }
    }
}

extension IcuPopView:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
