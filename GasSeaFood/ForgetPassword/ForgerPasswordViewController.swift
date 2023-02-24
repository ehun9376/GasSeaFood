//
//  ForgerPasswordViewController.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation
import UIKit

class ForgetPasswordViewController: BaseTableViewController {
    
    var viewModel: ForgerPasswordViewModel?
    
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

extension ForgetPasswordViewController: ForgetPasswordMethod {
    
    func resetButtonAction(success: Bool, model: RegisModel?) {
        if let model = model {
            let vc = ResetPasswordViewController(model: model)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showToast(message: "查無此號碼")
        }

    }

}
