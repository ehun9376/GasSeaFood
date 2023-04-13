//
//  TodayListViewModel.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/3/1.
//

import Foundation

protocol TodayListMethod {
    func cellDidSelect(title: String)
}

class TodayListViewModel: NSObject {
    
    
    var delegate: TodayListMethod?
    
    var adapter: TableViewAdapter?
    
    init(delegate: TodayListMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    
    func setupRow(index: Int = 0) {
        var rowModels: [CellRowModel] = []
        
        
        var list: [String] = []
        switch index {
        case 0:
            list = ["訂單1","訂單2","訂單3","訂單4"]
        case 1:
            list = ["訂單5","訂單6","訂單7","訂單8"]
        default:
            break
        }
        
        for order in list {
            let row = TodayListCellRowModel(title: order,
                                            titleLabelAction: { [weak self] in
                self?.delegate?.cellDidSelect(title: order)
            })
            rowModels.append(row)
        }
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
    }
    
}
