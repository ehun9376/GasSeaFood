//
//  TodayListViewModel.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/3/1.
//

import Foundation

protocol TodayListMethod {
    func cellDidSelect(model: GasOrderModel)
}

class TodayListViewModel: NSObject {
    
    
    var delegate: TodayListMethod?
    
    var adapter: TableViewAdapter?
    
    init(delegate: TodayListMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    var orderListModel: GasOrderListModel?
    
    
    func setupRow(index: Int = 0) {
        var rowModels: [CellRowModel] = []

        for order in orderListModel?.list ?? [] {
            let row = TodayListCellRowModel(title: "訂單:\(order.orderID ?? "")",
                                            titleLabelAction: { [weak self] in
                self?.delegate?.cellDidSelect(model: order)
            })
            rowModels.append(row)
        }
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }
    
    
    func getGasOrderAPI() {
        APIService.shared.requestWithParam(urlText: .gasOrder, params: [:], modelType: GasOrderListModel.self) { jsonModel, error in
            if let jsonModel = jsonModel {
                self.orderListModel = jsonModel
                self.setupRow()
            }
        }
    }
    
}
