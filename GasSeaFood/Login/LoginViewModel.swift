//
//  LoginViewModel.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/23.
//

import Foundation

protocol LoginMethod {
    
    func loginComplete()
    
    func forgetPasswordAction()
    
}


class LoginViewModel: NSObject {
    
    var adapter: TableViewAdapter?
    
    var delegate: LoginMethod?
    
    init(
        adapter: TableViewAdapter?,
        delegate: LoginMethod?
    ){
        self.adapter = adapter
        self.delegate = delegate
    }
    
    func setupRow() {
        
        var rowModels: [CellRowModel] = []
        
        let imageRow = TitleImageRowModel(title: "登入", imageName: "door")
        
        rowModels.append(imageRow)
        
        let accountRow = TitleTextFieldRowModel(title: "員工編號",
                                                placeHolder: "請輸入您的會員號碼",
                                                textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(accountRow)
        
        let passwordRow = TitleTextFieldRowModel(title: "密碼",
                                                 placeHolder: "請輸入您的密碼",
                                                 textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(passwordRow)
        
        let forgetPasswordRowModel = LabelCellRowModel(title: "忘記密碼", labelTapAction: { [weak self] in
            self?.delegate?.forgetPasswordAction()
        })
        
        rowModels.append(forgetPasswordRowModel)
        
        let emptyRowModel = EmptyHeightRowModel(cellHeight: 50.0, color: .white)
        00
        rowModels.append(emptyRowModel)
        
        let loginRowModel = ButtonCellRowModel(buttonTitle: "登入", buttonAction: { [weak self] in
            self?.delegate?.loginComplete()
        })
        
        rowModels.append(loginRowModel)
        
        
        
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    
    
    
}
