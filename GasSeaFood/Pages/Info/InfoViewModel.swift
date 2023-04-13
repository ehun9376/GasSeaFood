//
//  InfoViewModel.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation

protocol InfoMethod {
    func save(success: Bool)
}

class InfoViewModel: NSObject {
    
    var delegate: InfoMethod?
    
    var adapter: TableViewAdapter?
    
    var defaultNumber: String = ""
    
    var regisModel: RegisModel?
    
    init(delegate: InfoMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRow() {
//        guard let model = UserInfoCenter.shared.loadData(modelType: [RegisModel].self, .regisModelList)?.first(where: {$0.cellphoneNumber == self.defaultNumber}) else { return }
//
//        self.regisModel = model
//
//        var rowModels: [CellRowModel] = []
//
//        let nameRow = TitleTextFieldRowModel(title: "姓名", text: model.name, placeHolder: "請輸入姓名", required: true) { text in
//            self.regisModel?.name = text
//        }
//
//        rowModels.append(nameRow)
//
//        let cellphoneRow = TitleTextFieldRowModel(title: "手機號碼", text: model.cellphoneNumber, placeHolder: "請輸入姓名", required: true, canEdit: false) { text in
//            self.regisModel?.cellphoneNumber = text
//        }
//
//        rowModels.append(cellphoneRow)
//
//        let gasRow = TitleTextFieldRowModel(title: "瓦斯行", text: model.gas, placeHolder: "請輸入姓名", required: true) { text in
//            self.regisModel?.gas = text
//        }
//
//        rowModels.append(gasRow)
//
//        let emailRow = TitleTextFieldRowModel(title: "電子信箱", text: model.email, placeHolder: "請輸入姓名", required: true) { text in
//            self.regisModel?.email = text
//        }
//
//        rowModels.append(emailRow)
//
//        let saveRow = ButtonCellRowModel(buttonTitle: "儲存", buttonHeight: 50, buttonAction: {
//            if var array = UserInfoCenter.shared.loadData(modelType: [RegisModel].self, .regisModelList) {
//                array = array.filter({$0.cellphoneNumber != self.defaultNumber})
//
//                array.append(self.regisModel ?? .init())
//
//                UserInfoCenter.shared.storeData(model: array, .regisModelList)
//
//                self.delegate?.save(success: true)
//                return
//            }
//
//            self.delegate?.save(success: false)
//
//
//        })
//
//        rowModels.append(saveRow)
//
//        self.adapter?.updateTableViewData(rowModels: rowModels)
//
        
    }
    
}
