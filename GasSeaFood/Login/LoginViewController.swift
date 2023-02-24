//
//  LoginViewController.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/23.
//

import Foundation
import UIKit

class LoginViewController: BaseTableViewController {
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem()
        self.regisCellID(cellIDs: [
            "TitleImageCell",
            "TitleTextFieldCell",
            "LabelCell",
            "ButtonCell",
            "EmptyHeightCell"
        ])

        self.viewModel = .init(adapter: .init(self.defaultTableView), delegate: self)
        self.viewModel?.setupRow()
        
    }

}

extension LoginViewController: LoginMethod {
    
    func loginComplete() {
        
    }
    
    func forgetPasswordAction() {
        let vc = ForgetPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
