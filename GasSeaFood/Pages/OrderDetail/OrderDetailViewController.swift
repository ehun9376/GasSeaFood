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
    
    let alertView = UIView()
    
    var tableView = UITableView()
    
    var adapter: TableViewAdapter?
    
    var gasOrderModel: GasOrderModel?
    
    var orderDetailListModel: OrderDetailListModel?
    
    var customModel: CustomModel?
    
    
    
    
    override func viewDidLoad() {
        self.title = "訂單資料"
        self.setupConfirmButton()
        self.setupVerStackView()
        self.getCustomerInfoAPI()
        self.view.backgroundColor = .white
        self.setupAlertView()
        self.setTableView()
        
    }
    
    func setTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.alertView.bottomAnchor, constant: 5),
            self.tableView.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.confirmButton.topAnchor, constant: -10)
        ])
        self.adapter = .init(self.tableView)
    }
        
    func getCustomerInfoAPI() {
        
        let id = gasOrderModel?.orderID ?? ""
        
        APIService.shared.requestWithParam(headerField: .form,urlText: .showOrderInfo, params: ["id": id], modelType: CustomModel.self) { [weak self] jsonModel, error in
            if let jsonModel = jsonModel {
                self?.customModel = jsonModel
                DispatchQueue.main.async {
                    self?.addSubViewInVerStackView()
                }
            }
        }
        
        APIService.shared.requestWithParam(headerField: .form, urlText: .workerOrderDetail, params: ["id": id], modelType: OrderDetailListModel.self) { [weak self] jsonModel, error in
            self?.orderDetailListModel = jsonModel
            self?.setupRow()
        }
    }
    
    func setupRow() {
        var rowModels: [CellRowModel] = []
        
        for model in self.orderDetailListModel?.list ?? [] {
            
            let type = (model.orderType ?? "") == "tradition" ? "傳統桶" : "複合桶"
            
            rowModels.append(OrderCellRowModel(type: type,
                                               quantity: model.orderQuantity ?? "",
                                               format: model.orderWeight ?? "",
                                               cellDidSelect: { [weak self] rowModel in
                let vc = QRCodeScannerViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }))
            
        }
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }
    
    func setupAlertView() {
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.backgroundColor = .yellow.withAlphaComponent(0.5)
        
        self.view.addSubview(alertView)
        
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: self.verStackView.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: self.verStackView.trailingAnchor),
            alertView.topAnchor.constraint(equalTo: self.verStackView.bottomAnchor,constant: 15)
        ])
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.text = "訂購瓦斯桶"
        label1.font = .systemFont(ofSize: 18, weight: .bold)
        
        
        alertView.addSubview(label1)
        
        NSLayoutConstraint.activate([
            label1.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,constant: 10),
            label1.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            label1.topAnchor.constraint(equalTo: alertView.topAnchor,constant: 15)
        ])
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "請按下面的列表來進行換桶流程，以一桶為單位"
        label2.font = .systemFont(ofSize: 16)
        label2.numberOfLines = 0
        label2.lineBreakMode = .byCharWrapping
        
        alertView.addSubview(label2)
        
        NSLayoutConstraint.activate([
            label2.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,constant: 10),
            label2.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor,constant: 5),
            label2.bottomAnchor.constraint(equalTo: alertView.bottomAnchor,constant: -10)
        ])
    }
    
    func setupVerStackView() {
        self.verStackView.axis = .vertical
        self.verStackView.spacing = 10
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
        
        self.confirmButton = self.createCommandButton(title: "確認所有換桶完成", action: { [weak self] in self?.navigationController?.popViewController(animated: true) })
        
        self.view.addSubview(self.confirmButton)
        NSLayoutConstraint.activate([
            self.confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    func addSubViewInVerStackView() {

        
        self.verStackView.addArrangedSubview(self.createView())
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "姓名", title2: customModel?.customName ?? ""))
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "聯絡電話", title2: gasOrderModel?.deliveryPhone ?? ""))
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "配送地址", title2: gasOrderModel?.deliveryAddress ?? ""))
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "訂購時間", title2: gasOrderModel?.orderTime ?? ""))
        self.verStackView.addArrangedSubview(self.createCommondHoriStackView(title1: "瓦斯桶數量", title2: gasOrderModel?.gasQuantity ?? ""))
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
        stackView.spacing = 10
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
