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
        
        self.defaultTableView.separatorStyle = .none
        
        self.regisCellID(cellIDs: [
            "TitleImageCell",
            "TitleTextFieldCell",
            "LabelCell",
            "ButtonCell",
            "EmptyHeightCell"
        ])
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEdit)))
        
        self.viewModel = .init(adapter: .init(self.defaultTableView), delegate: self)
        self.viewModel?.setupRow()
        
    }
    
    @objc func endEdit() {
        self.view.endEditing(true)
    }
}

extension LoginViewController: LoginMethod {
    
    func loginComplete() {
        
    }
    
    func forgetPasswordAction() {
        
    }
    
}
