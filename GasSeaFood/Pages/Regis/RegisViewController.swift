//
//  RegisViewController.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation

class RegisViewController: BaseTableViewController {
    
    var viewModel: RegisViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = .init()
        self.regisCellID(cellIDs: [
            "TitleImageCell",
            "TitleTextFieldCell",
            "LabelCell",
            "ButtonCell",
            "EmptyHeightCell",
            "TwoButtonCell",
            "TitleTwoButtonsTextfieldCell"
        ])

        self.viewModel = .init(delegate: self, adapter: .init(self.defaultTableView))
        self.viewModel?.setupRow()
        
    }
}

extension RegisViewController: RegisMethod {
    
    func regisComplete(success: Bool, message: String) {
        
        if success {
            self.showToast(message: message, complete: {
                self.dismiss(animated: true)
            })
        } else {
            self.showSingleAlert(title: "提示", message: message, confirmTitle: "OK", confirmAction: nil)
        }

    }
    
    
}
