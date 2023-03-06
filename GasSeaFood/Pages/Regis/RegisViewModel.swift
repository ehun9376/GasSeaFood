//
//  RegisViewModel.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation
import UIKit

struct RegisModel: Codable {
    
    var name: String = ""

    var sex: String = ""
    
    var address: String = ""
    
    var cellphoneNumber: String = ""
    
    var phoneNumber: String = ""
    
    var email: String = ""
    
    var password: String = ""
    
    var confirmPassword: String = ""
    
    var inviewCode: String = ""
    
    var gas: String = ""
    
    var rule: Bool = false
    
}

protocol RegisMethod {
    func regisComplete(success: Bool)
}

class RegisViewModel: NSObject {
    
    var delegate: RegisMethod?
    
    var adapter: TableViewAdapter?
    
    var regisModel = RegisModel()
    
    init(delegate: RegisMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRow() {
        
        var rowModels: [CellRowModel] = []
        
        
        let nameRow = TitleTextFieldRowModel(title: "名字",
                                             text: self.regisModel.name,
                                                textDidChange: { [weak self] text in
            self?.regisModel.name = text
        })
        
        rowModels.append(nameRow)
        
        let sexRow = TwoButtonRowModel(buttonAction: { [weak self] text in
            self?.regisModel.sex = text
        })
        
        rowModels.append(sexRow)
        
        let addressRow = TitleTwoButtonsTextfieldRowModel(title: "居住地址",
                                                          country: "縣/市",
                                                          area: "地區",
                                                          textDidChange: {[weak self] text in
            self?.regisModel.address = text
        })
        
        rowModels.append(addressRow)
        
//        let addressRow = TitleTextFieldRowModel(title: "居住地址",
//                                                 textDidChange: { [weak self] text in
//
//        })
//
//        rowModels.append(addressRow)
        
        let cellphoneRow = TitleTextFieldRowModel(title: "手機號碼",
                                                  text: self.regisModel.cellphoneNumber,
                                                 textDidChange: { [weak self] text in
            self?.regisModel.cellphoneNumber = text
        })
        
        rowModels.append(cellphoneRow)
        
        let phoneRow = TitleTextFieldRowModel(title: "市內電話號碼",
                                              text: self.regisModel.phoneNumber,
                                                 textDidChange: { [weak self] text in
            self?.regisModel.phoneNumber = text
        })
        
        rowModels.append(phoneRow)
        
        let emailRow = TitleTextFieldRowModel(title: "電子信箱",
                                              text: self.regisModel.email,
                                                 textDidChange: { [weak self] text in
            self?.regisModel.email = text
        })
        
        rowModels.append(emailRow)
        
        let passwordRow = TitleTextFieldRowModel(title: "密碼",
                                                 text: self.regisModel.password,
                                                 textDidChange: { [weak self] text in
            self?.regisModel.password = text
        })
        
        rowModels.append(passwordRow)
        
        let confirmPasswordRow = TitleTextFieldRowModel(title: "確認密碼",
                                                        text: self.regisModel.confirmPassword,
                                                 textDidChange: { [weak self] text in
            self?.regisModel.confirmPassword = text
        })
        
        rowModels.append(confirmPasswordRow)
        
        let inviteCodeRow = TitleTextFieldRowModel(title: "家人邀請碼",
                                                   text: self.regisModel.inviewCode,
                                                   required: false,
                                                   textDidChange: { [weak self] text in
            self?.regisModel.inviewCode = text
        })
        
        rowModels.append(inviteCodeRow)
        
        let ruleRow = LabelCellRowModel(titleAttr: .init(string: "服務條款",
                                                         attributes: [
                                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]),
                                        needImage: true,
                                        labelTapAction: {
            self.regisModel.rule.toggle()
        })
        
        rowModels.append(ruleRow)
        
        let regisRowModel = ButtonCellRowModel(buttonTitle: "完成註冊", buttonAction: { [weak self] in
            
            guard let model = self?.regisModel else { return }
            
            
            if var array = UserInfoCenter.shared.loadData(modelType: [RegisModel].self, .regisModelList) {
                array.append(model)
                
                UserInfoCenter.shared.storeData(model: array, .regisModelList)
                self?.delegate?.regisComplete(success: true)
                return
            } else {
                let array: [RegisModel] = [model]
                
                UserInfoCenter.shared.storeData(model: array, .regisModelList)
                self?.delegate?.regisComplete(success: true)
                return
            }
            self?.delegate?.regisComplete(success: false)
            
            
        })
        
        rowModels.append(regisRowModel)
        
        
        
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }
    
}
