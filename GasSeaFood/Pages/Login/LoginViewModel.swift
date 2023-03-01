//
//  LoginViewModel.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/23.
//

import Foundation
import UIKit

protocol LoginMethod {
    
    func loginComplete(success:Bool, number: String)
    
    func forgetPasswordAction()
    
}


class LoginViewModel: NSObject {
    
    var adapter: TableViewAdapter?
    
    var delegate: LoginMethod?
    
    var password: String = ""
    
    var account: String = ""
    
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
        
        let accountRow = TitleTextFieldRowModel(title: "手機號碼",
                                                placeHolder: "請輸入您的手機號碼",
                                                textDidChange: { [weak self] text in
            self?.account = text ?? ""
        })
        
        rowModels.append(accountRow)
        
        let passwordRow = TitleTextFieldRowModel(title: "密碼",
                                                 placeHolder: "請輸入您的密碼",
                                                 textDidChange: { [weak self] text in
            self?.password = text ?? ""
        })
        
        rowModels.append(passwordRow)
        
        let attr = NSAttributedString(string: "忘記密碼",
                                      attributes: [
                                        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                        NSAttributedString.Key.foregroundColor: UIColor.lightGray
                                      ])
        
        let forgetPasswordRowModel = LabelCellRowModel(titleAttr: attr, labelTapAction: { [weak self] in
            self?.delegate?.forgetPasswordAction()
        })
        
        rowModels.append(forgetPasswordRowModel)
        
        let emptyRowModel = EmptyHeightRowModel(cellHeight: 50.0, color: .white)
        
        rowModels.append(emptyRowModel)
        
        let loginRowModel = ButtonCellRowModel(buttonTitle: "登入", buttonAction: { [weak self] in
            self?.delegate?.loginComplete(success: true, number: "111")
            
//            if let models = UserInfoCenter.shared.loadData(modelType: [RegisModel].self, .regisModelList) {
//                if let _ = models.first(where: {($0.cellphoneNumber ?? "") == (self?.account ?? "") && ($0.password ?? "") == (self?.password ?? "") }) {
//                    self?.delegate?.loginComplete(success: true, number: self?.account ?? "")
//                    return
//                }
//            }
//
//            self?.delegate?.loginComplete(success: false, number: "")
        })
        
        rowModels.append(loginRowModel)
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    
    
    
}
