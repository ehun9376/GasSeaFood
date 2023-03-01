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
    
    var attr: NSAttributedString?
    
    init(
        cellHeight: CGFloat,
        color: UIColor = .white,
        attr: NSAttributedString? = nil
    ) {
        self.cellHeight = cellHeight
        self.color = color
        self.attr = attr
    }
}

class EmptyHeightCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var cellViewHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        titleLabel.numberOfLines = 0
    }
    
}

extension EmptyHeightCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? EmptyHeightRowModel else { return }
        
        self.cellViewHeight.constant = rowModel.cellHeight
        self.backView.backgroundColor = rowModel.color
        
        if let attr = rowModel.attr {
            self.titleLabel.attributedText = attr
            self.titleLabel.isHidden = false
        } else {
            self.titleLabel.isHidden = true
        }
        
    }
}
