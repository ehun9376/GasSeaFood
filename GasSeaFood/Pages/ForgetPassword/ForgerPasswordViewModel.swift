//
//  ForgerPasswordViewModel.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation

protocol ForgetPasswordMethod {
    func resetButtonAction(success: Bool, model: RegisModel?)
}

class ForgerPasswordViewModel: NSObject {
    
    var delegate: ForgetPasswordMethod?
    
    var adapter: TableViewAdapter?
    
    var number: String = ""
    
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
        
        let passwordRow = TitleTextFieldRowModel(title: "驗證碼",
                                                 placeHolder: "請輸入您的驗證碼",
                                                 textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(passwordRow)
        
        let emptyRowModel = EmptyHeightRowModel(cellHeight: 87.0, color: .white)
        
        rowModels.append(emptyRowModel)
        
        let loginRowModel = ButtonCellRowModel(buttonTitle: "重新設定密碼", buttonAction: { [weak self] in
            guard let model = UserInfoCenter.shared.loadData(modelType: [RegisModel].self, .regisModelList)?.first(where: {$0.cellphoneNumber == self?.number}) else {
                self?.delegate?.resetButtonAction(success: false, model: nil)
                return
            }
            
            self?.delegate?.resetButtonAction(success: true, model: model)
        })
        
        rowModels.append(loginRowModel)
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
}
