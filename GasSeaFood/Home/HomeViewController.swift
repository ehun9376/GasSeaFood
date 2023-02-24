//
//  HomeViewController.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation
import UIKit

class HomeViewController: BaseTableViewController {
    
    var viewModel: HomeViewModel?
    
    convenience init(
        number: String
    ){
        self.init()
        self.viewModel = .init(adapter: .init(self.defaultTableView), delegate: self, defaultNumber: number)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首頁"
        
        self.regisCellID(cellIDs: [
            "ButtonCell",
            "HeadInfoCell",
            "EmptyHeightCell"
        ])
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.setupRow()
    }
    
}

extension HomeViewController: HomeMethod {
    func logout() {
        
        self.showToast(message: "已登出") {
            let vc = LaunchViewController()
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }

    }
    
    func infoAction() {
        let vc = InfoViewController(number: self.viewModel?.defaultNumber ?? "")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

