//
//  LabelCell.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/23.
//

import Foundation
import UIKit

class LabelCellRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "LabelCell"
    }
    var title: String?
    
    var labelTapAction: (()->())?
    
    init(title: String? = nil, labelTapAction: (() -> ())? = nil) {
        self.title = title
        self.labelTapAction = labelTapAction
    }
}

class LabelCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var rowModel: LabelCellRowModel?
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapAction))
        tap.numberOfTapsRequired = 1
        
        self.titleLabel.addGestureRecognizer(tap)
        self.titleLabel.isUserInteractionEnabled = true
        self.titleLabel.textAlignment = .center
    }
    
    @objc func labelTapAction() {
        self.rowModel?.labelTapAction?()
    }
}

extension LabelCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? LabelCellRowModel else { return }
        let attr = NSAttributedString(string: rowModel.title ?? "",
                                      attributes: [
                                        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                        NSAttributedString.Key.foregroundColor: UIColor.lightGray
                                      ])
        self.titleLabel.attributedText = attr
    }
}
