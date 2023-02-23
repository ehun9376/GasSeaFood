//
//  TitleTextFiextCell.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/23.
//

import Foundation
import UIKit

class TitleTextFieldRowModel: CellRowModel {
    
    override func cellReUseID() -> String {
        return "TitleTextFieldCell"
    }
    
    var title: String?
    
    var textDidChange: ((String?)->())?
    
    var placeHolder: String?
    
    init(title: String? = nil, placeHolder: String?, textDidChange: ((String?) -> ())? = nil) {
        self.title = title
        self.placeHolder = placeHolder
        self.textDidChange = textDidChange
    }
    
}

class TitleTextFieldCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    var rowModel: TitleTextFieldRowModel?

    override func awakeFromNib() {
        self.selectionStyle = .none
        self.contentTextField.addTarget(self, action: #selector(textFieldDidEdit(_:)), for: .valueChanged)
        
        self.titleLabel.font = .systemFont(ofSize: 18,weight: .bold)
    }
    
    @objc func textFieldDidEdit(_ sender: UITextField) {
        self.rowModel?.textDidChange?(sender.text)
    }
    
}


extension TitleTextFieldCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? TitleTextFieldRowModel else { return }
        self.rowModel = rowModel
        self.titleLabel.text = rowModel.title
        
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        self.contentTextField.attributedPlaceholder = NSAttributedString(
            string: rowModel.placeHolder ?? "",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
    }
}
