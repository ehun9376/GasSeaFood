//
//  EmptyHeightCell.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/23.
//

import Foundation
import UIKit

class EmptyHeightRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "EmptyHeightCell"
    }
    
    var cellHeight: CGFloat = 0
    
    var color: UIColor = .white
    init(
        cellHeight: CGFloat,
        color: UIColor = .white
    ) {
        self.cellHeight = cellHeight
        self.color = color
    }
}

class EmptyHeightCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var cellViewHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        
    }
    
}

extension EmptyHeightCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? EmptyHeightRowModel else { return }
        
        self.cellViewHeight.constant = rowModel.cellHeight
        self.backView.backgroundColor = rowModel.color
    }
}
