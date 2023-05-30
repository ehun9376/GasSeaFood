//
//  LessGasViewController.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/5/31.
//

import Foundation
import UIKit

class LessGasViewController: BaseViewController {
    
    let tableView = UITableView()
    
    var adapter: TableViewAdapter?
    
    var lessGasCount: Int = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "殘氣結算"

        self.view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewAction))
        tap.numberOfTapsRequired = 1
        
        self.view.addGestureRecognizer(tap)

        
        self.setupTableView()
        
        self.setupRow()
                
    }
    
    @objc func viewAction() {
        self.view.endEditing(true)
    }
    
    override func defaultNavigationSet() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .init(hex: "D60702")
        UINavigationBar.appearance().tintColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    func setupTableView() {
        
        self.adapter = .init(self.tableView)
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10)
        ])
        
        self.tableView.register(.init(nibName: "TitleTextFieldCell", bundle: nil), forCellReuseIdentifier: "TitleTextFieldCell")
        self.tableView.register(.init(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
        self.tableView.register(.init(nibName: "EmptyHeightCell", bundle: nil), forCellReuseIdentifier: "EmptyHeightCell")
        self.tableView.register(.init(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
    }
    
    func setupRow() {
        
        var rowModels: [CellRowModel] = []
        
        let firstAttr = NSMutableAttributedString(string: "殘氣結算\n\n", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28, weight: .bold)
        ])
        
            
        let secondAttr = NSMutableAttributedString(string: "瓦斯桶行 XXX", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold),
        ])
        
        firstAttr.append(secondAttr)

        let titleRow = EmptyHeightRowModel(cellHeight: 200, color: .white, attr: firstAttr, textAligment: .left)
        
        rowModels.append(titleRow)
        
        for _ in 0..<self.lessGasCount {
            let lessGasRow = TitleTextFieldRowModel(title: "輸入殘氣結算",
                                                    text: "",
                                                    required: true,
                                                    textDidChange: { [weak self] text in
            })
            
            rowModels.append(lessGasRow)
        }
        
        if self.lessGasCount < 3 {
            let addLessGasRow = ButtonCellRowModel(buttonTitle: "+ 下一個", buttonColor: .init(hex: "AAA8A9") , buttonAction: {
                self.lessGasCount += 1
                self.setupRow()
            })
            
            rowModels.append(addLessGasRow)
        }
        
        let emptyRow = EmptyHeightRowModel(cellHeight: 200, color: .white, attr: nil)
        
        rowModels.append(emptyRow)

        
        let buttonRow = ButtonCellRowModel(buttonTitle: "掃瞄新瓦斯桶 ->", buttonAction: {
            let vc = QRCodeScannerViewController()
            vc.hasOld = true
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        rowModels.append(buttonRow)
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
  
    
    func showAlert(success: Bool, complete: (()->())? = nil) {
        
        let alert = CustomAlertController(title: success ? "瓦斯桶配對成功" : "換桶失敗",
                                          content: success ? "已通知換桶成功" : "請重新掃描",
                                          imageName: success ? "success" : "faild",
                                          buttonTitle: "確定",
                                          dismissAction: {
            complete?()
        })
        self.present(alert, animated: true)
    }

    func found(code: String) {
        
        self.showAlert(success: true, complete: { [ weak self] in
            self?.setupRow()
        })
        
 
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
