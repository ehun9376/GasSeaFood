//
//  ResetPasswordView.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//
import Foundation


protocol ResetPasswordViewMethod {
    func saveAndReturnAction()
}

class ResetPasswordViewModel: NSObject {
    
    var delegate: ResetPasswordViewMethod?
    
    var adapter: TableViewAdapter?
    
    init(delegate: ResetPasswordViewMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    
    func setupRowModel() {
        
        var rowModels: [CellRowModel] = []
        
        let imageRow = TitleImageRowModel(title: "忘記密碼", imageName: "lock")
        
        rowModels.append(imageRow)
        
        let phoneRowModel = TitleTextFieldRowModel(title: "設定新密碼",
                                                placeHolder: "請輸入您的新密碼",
                                                textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(phoneRowModel)
        
        let passwordRow = TitleTextFieldRowModel(title: "再次輸入新密碼",
                                                 placeHolder: "請再次輸入新密碼",
                                                 textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(passwordRow)
        
        let emptyRowModel = EmptyHeightRowModel(cellHeight: 87.0, color: .white)
        
        rowModels.append(emptyRowModel)
        
        let loginRowModel = ButtonCellRowModel(buttonTitle: "返回登入畫面", buttonAction: { [weak self] in
            self?.delegate?.saveAndReturnAction()
        })
        
        rowModels.append(loginRowModel)
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
}

