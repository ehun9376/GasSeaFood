//
//  InfoViewController.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation

class InfoViewController: BaseTableViewController {
    
    var viewModel: InfoViewModel?
    
    convenience init(
        number: String
    ) {
        self.init()
        self.viewModel = .init(delegate: self, adapter: .init(self.defaultTableView), number: number)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "編輯個人檔案"
        navigationItem.backBarButtonItem = .init()

        regisCellID(cellIDs: [
            "TitleTextFieldCell",
            "ButtonCell"
        ])
        
        self.viewModel?.setupRow()
    }
    
}

extension InfoViewController: InfoMethod {
    func save(success: Bool) {
        if success {
            self.showToast(message: "已更新成功", complete: {
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            self.showToast(message: "更新失敗")
        }

    }
}
