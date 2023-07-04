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
    
    func resetButtonAction(success: Bool, message: String) {
        DispatchQueue.main.async {
            self.showSingleAlert(title: "提示", message: message, confirmTitle: "OK", confirmAction: { [weak self] in
                if success {
                    if success {
                        self?.showInputDialog(title: "請輸入驗證碼", actionTitle: "OK", actionHandler: { text in
                            if let text = text {
                                self?.viewModel?.verifyCode(Int(text) ?? 0)
                            }
                        })
                    } else {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            })
        }

    }
    
    func verifyButtonAction(success: Bool, message: String) {
        if success {
            self.showInputDialog(title: "請輸入新密碼", actionTitle: "OK", actionHandler:  { text in
                if let text = text {
                    self.viewModel?.changePassword(text)
                }
            })
        } else {
            self.showSingleAlert(title: "驗證碼錯誤", confirmTitle: "OK")
        }
    }
    
    func changePasswordCompletion(success: Bool, message: String) {
        DispatchQueue.main.async {
            self.showSingleAlert(title: message, confirmTitle: "OK")
            if success {
                self.dismiss(animated: true)
            }
        }
    }

}
