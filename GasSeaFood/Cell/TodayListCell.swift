//
//  TodayListCell.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/3/1.
//

import Foundation
import UIKit

class TodayListCellRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "TodayListCell"
    }
    
    var title: String?
    
    init(title: String? = nil) {
        self.title = title
    }
}

class TodayListCell: UITableViewCell {
    
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        
        self.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        self.insideView.layer.cornerRadius = 5
        self.insideView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        self.insideView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.insideView.layer.shadowOpacity = 1.0
        self.insideView.layer.shadowRadius = 5.0
    }
    
}

extension TodayListCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? TodayListCellRowModel else { return }
        
        self.titleLabel.text = rowModel.title
    }
}
