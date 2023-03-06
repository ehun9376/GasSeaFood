//
//  HomeViewModel.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation

protocol HomeMethod {
    func logout()
    func infoAction()
    func gotoScane()
    func gotoList()
}

class HomeViewModel: NSObject {
    
    var adapter: TableViewAdapter?
    
    var delegate: HomeMethod?
    
    var defaultNumber: String = ""
    
    var regisModel: RegisModel?
    
    init(adapter: TableViewAdapter? = nil, delegate: HomeMethod? = nil, defaultNumber: String) {
        self.adapter = adapter
        self.delegate = delegate
        self.defaultNumber = defaultNumber
    }
    
    func setupRow() {
        let model = UserInfoCenter.shared.loadData(modelType: [RegisModel].self, .regisModelList)?.first(where: {$0.cellphoneNumber == self.defaultNumber})
        
        self.regisModel = model
        
        var rowModels: [CellRowModel] = []
        
        let empty = EmptyHeightRowModel(cellHeight: 100, color: .white)
        
        rowModels.append(empty)
        
        let nameRow = HeadInfoRowModel(name: model?.name ?? "",
                                       infoAction: {
            self.delegate?.infoAction()
        },
                                       logoutAcction: {
            self.delegate?.logout()
        })
        
        rowModels.append(nameRow)
        
        let todayListRow = ButtonCellRowModel(buttonTitle: "今日訂單", buttonHeight: 150, buttonAction: {
            self.delegate?.gotoList()
        })
        
        rowModels.append(todayListRow)
        
        let scanRow = ButtonCellRowModel(buttonTitle: "前往掃描頁面", buttonHeight: 150, buttonAction: {
            self.delegate?.gotoScane()
        })
        
        rowModels.append(scanRow)
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }
    
}
