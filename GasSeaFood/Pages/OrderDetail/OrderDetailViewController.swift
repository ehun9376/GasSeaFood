//
//  OrderDetailViewController.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/4/13.
//

import Foundation
import UIKit

class OrderDetailViewController: BaseViewController {
    
    var naviTitle: String = ""
    
    let verStackView = UIStackView()
    
    var confirmButton = UIButton()
    
    override func viewDidLoad() {
        self.title = naviTitle
        self.setupConfirmButton()
        self.setupVerStackView()
        self.addSubViewInVerStackView()
        self.view.backgroundColor = .white
    }
    
    func setupVerStackView() {
        self.verStackView.axis = .vertical
        self.verStackView.spacing = 30
        self.verStackView.distribution = .fill
        self.verStackView.translatesAutoresizingMaskIntoConstraints = false
        self.verStackView.backgroundColor = .init(hex: "E9EBEA")
        self.verStackView.layer.cornerRadius = 10
        self.verStackView.clipsToBounds = true

        
        self.view.addSubview(self.verStackView)
        NSLayoutConstraint.activate([
            self.verStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.verStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.verStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        ])
    }
    
    func setupConfirmButton() {
        
        self.confirmButton = self.createCommandButton(title: "確認", action: { [weak self] in self?.navigationController?.popViewController(animated: true) })
        
        self.view.addSubview(self.confirmButton)
        NSLayoutConstraint.activate([
            self.confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    func addSubViewInVerStackView() {

        
        self.verStackView.addArrangedSubview(self.createView())
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "姓名", title2: "陳XX"))
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "聯絡電話", title2: "0987xxxx"))
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "配送地址", title2: "台北市中山區"))
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "瓦斯桶ID", title2: "xxx"))
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "瓦斯桶數量", title2: "1桶"))
        self.verStackView.addArrangedSubview(self.createView())
    }
    
    func createView() -> UIView {
        let view1 = UIView()
        view1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view1.backgroundColor = .clear
        
        return view1
    }
    
    func createCommandButton(title: String, action: (()->())?) -> UIButton {
        let button = ActionButton(action: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(hex: "3472D9")
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 5.0
        
        return button
    }
    
    func createCommondHoriStackView(title1: String, title2: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        stackView.addArrangedSubview(self.createCommondLabel(title: title1))
        stackView.addArrangedSubview(self.createCommondLabel(title: title2))
        
        return stackView
        
        
    }
    
    func createCommondLabel(title: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(hex: "7F7F7F")
        label.textAlignment = .center
        label.text = title
        label.numberOfLines = 0
        
        return label
        
    }
    
}
