//
//  ButtonCell.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/23.
//

import Foundation
import UIKit

class ButtonCellRowModel: CellRowModel {
    
    override func cellReUseID() -> String {
        "ButtonCell"
    }
    
    var buttonTitle: String?
    
    var buttonAction: (()->())?
    
    init(
        buttonTitle: String?,
        buttonAction: (()->())?
    ) {
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
}

class ButtonCell: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    var rowModel: ButtonCellRowModel?
    
    override func awakeFromNib() {
        self.setButton(button: self.button)
    }
    
    func setButton(button: UIButton){
        
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(hex: "3472D9")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 5.0
        
    }
    
    @objc func buttonAction() {
        self.rowModel?.buttonAction?()
    }
}

extension ButtonCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? ButtonCellRowModel else { return }
        self.rowModel = rowModel
        self.button.setTitle(rowModel.buttonTitle, for: .normal)
    }
}
