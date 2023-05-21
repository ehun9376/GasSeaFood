//
//  ForgerPasswordViewModel.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation

protocol ForgetPasswordMethod {
    func resetButtonAction(success: Bool, message: String)
}

class ForgerPasswordViewModel: NSObject {
    
    var delegate: ForgetPasswordMethod?
    
    var adapter: TableViewAdapter?
    
    var number: String = ""
    
    var email: String = ""
    
    init(delegate: ForgetPasswordMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRowModel() {
        
        var rowModels: [CellRowModel] = []
        
        let imageRow = TitleImageRowModel(title: "忘記密碼", imageName: "lock")
        
        rowModels.append(imageRow)
        
        let phoneRowModel = TitleTextFieldRowModel(title: "手機號碼",
                                                placeHolder: "請輸入您的手機號碼",
                                                textDidChange: { [weak self] text in
            self?.number = text
        })
        
        rowModels.append(phoneRowModel)
        
        let passwordRow = TitleTextFieldRowModel(title: "Email",
                                                 placeHolder: "請輸入您的Email",
                                                 textDidChange: { text in
            self.email = text
        })
        
        rowModels.append(passwordRow)
        
        let emptyRowModel = EmptyHeightRowModel(cellHeight: 87.0, color: .white)
        
        rowModels.append(emptyRowModel)
        
        let loginRowModel = ButtonCellRowModel(buttonTitle: "重新設定密碼", buttonAction: { [weak self] in
            self?.sendPasswordMail()
        })
        
        rowModels.append(loginRowModel)
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    func sendPasswordMail() {
        
        let param: parameter = [
            "WORKER_PhoneNum": self.number,
            "WORKER_Email": self.email,
            "test": "\(Int.random(in: 0...9999))"
        ]
        
        APIService.shared.requestWithParam(httpMethod: .post, urlText: .sendMail, params: param, modelType: DefaultSuccessModel.self) { [weak self] jsonModel, error in
            self?.delegate?.resetButtonAction(success: jsonModel?.status ?? false, message: jsonModel?.message ?? "未知錯誤，請再試一次")
        }
        
    }
}
