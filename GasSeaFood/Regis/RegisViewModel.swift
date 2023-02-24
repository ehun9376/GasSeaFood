//
//  RegisViewModel.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation
import UIKit

protocol RegisMethod {
    func regisComplete()
}

class RegisViewModel: NSObject {
    
    var delegate: RegisMethod?
    
    var adapter: TableViewAdapter?
    
    init(delegate: RegisMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRow() {
        
        var rowModels: [CellRowModel] = []
        
        
        let nameRow = TitleTextFieldRowModel(title: "名字",
                                                textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(nameRow)
        
        let sexRow = TwoButtonRowModel(buttonAction: { [weak self] text in
            
        })
        
        rowModels.append(sexRow)
        
        let addressRow = TitleTwoButtonsTextfieldRowModel(title: "居住地址",
                                                          country: "縣/市",
                                                          area: "地區",
                                                          countryButtonAction: { [weak self] _ in
            
        },
                                                          areaButtonAction: {[weak self] _ in
            
        },
                                                          textDidChange: {[weak self] _ in
            
        })
        
        rowModels.append(addressRow)
        
//        let addressRow = TitleTextFieldRowModel(title: "居住地址",
//                                                 textDidChange: { [weak self] text in
//
//        })
//
//        rowModels.append(addressRow)
        
        let cellphoneRow = TitleTextFieldRowModel(title: "手機號碼",
                                                 textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(cellphoneRow)
        
        let phoneRow = TitleTextFieldRowModel(title: "市內電話號碼",
                                                 textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(phoneRow)
        
        let emailRow = TitleTextFieldRowModel(title: "電子信箱",
                                                 textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(emailRow)
        
        let passwordRow = TitleTextFieldRowModel(title: "密碼",
                                                 textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(passwordRow)
        
        let confirmPasswordRow = TitleTextFieldRowModel(title: "確認密碼",
                                                 textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(confirmPasswordRow)
        
        let inviteCodeRow = TitleTextFieldRowModel(title: "家人邀請碼",
                                                   required: false,
                                                   textDidChange: { [weak self] text in
            
        })
        
        rowModels.append(inviteCodeRow)
        
        let ruleRow = LabelCellRowModel(titleAttr: .init(string: "服務條款",
                                                         attributes: [
                                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]),
                                        needImage: true,
                                        labelTapAction: {
            
        })
        
        rowModels.append(ruleRow)
        
        let regisRowModel = ButtonCellRowModel(buttonTitle: "完成註冊", buttonAction: { [weak self] in
            self?.delegate?.regisComplete()
        })
        
        rowModels.append(regisRowModel)
        
        
        
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }
    
}
