//
//  ResetPasswordViewController.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation
import UIKit

class ResetPasswordViewController: BaseTableViewController {
    
    var viewModel: ResetPasswordViewModel?
    
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
        self.viewModel = .init(delegate: self, adapter: .init(self.defaultTableView))
        self.viewModel?.setupRowModel()
    }
    
    
}

extension ResetPasswordViewController: ResetPasswordViewMethod {
    
    func saveAndReturnAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
