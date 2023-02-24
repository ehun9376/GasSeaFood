//
//  TitleTwoButtonsTextfieldCell.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/2/24.
//

import Foundation
import UIKit

class TitleTwoButtonsTextfieldRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "TitleTwoButtonsTextfieldCell"
    }
    
    var title: String?
    
    var country: String?
    
    var area: String?
    
    var textDidChange: ((String)->())?
    
    init(title: String? = nil, country: String? = nil, area: String? = nil, textDidChange: ( (String) -> ())? = nil) {
        self.title = title
        self.country = country
        self.area = area
        self.textDidChange = textDidChange
    }
    
}

class TitleTwoButtonsTextfieldCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var countryButton: UIButton!
    
    @IBOutlet weak var areaButton: UIButton!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    var rowModel: TitleTwoButtonsTextfieldRowModel?
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        self.contentTextField.addTarget(self, action: #selector(textFieldDidEdit(_:)), for: .valueChanged)
        
        self.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        if #available(iOS 15.0, *) {
            self.countryButton.configuration = nil
        }
        
        self.countryButton.setTitleColor(.white, for: .normal)
        self.countryButton.backgroundColor = .init(hex: "3472D9")
        self.countryButton.semanticContentAttribute = .forceRightToLeft
        self.countryButton.setImage(UIImage(named: "traingle")?.resizeImage(targetSize: .init(width: 15, height: 15)).withRenderingMode(.alwaysTemplate), for: .normal)
        self.countryButton.tintColor = .white
        self.countryButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        self.countryButton.titleLabel?.textAlignment = .left
        self.countryButton.layer.cornerRadius = 8
        self.countryButton.showsMenuAsPrimaryAction = true
        self.countryButton.menu = UIMenu(
            title: "",
            children: [
                UIAction(title: "台北") { [weak self] action in self?.setCountryButtonTitle(title: action.title)},
                UIAction(title: "台中") { [weak self] action in self?.setCountryButtonTitle(title: action.title) },
                UIAction(title: "台南") { [weak self] action in self?.setCountryButtonTitle(title: action.title) },
                UIAction(title: "高雄") { [weak self] action in self?.setCountryButtonTitle(title: action.title) },
            ]
        )
        
        if #available(iOS 15.0, *) {
            self.areaButton.configuration = nil
        }
        self.areaButton.setTitleColor(.white, for: .normal)
        self.areaButton.backgroundColor = .init(hex: "3472D9")
        self.areaButton.semanticContentAttribute = .forceRightToLeft
        self.areaButton.setImage(UIImage(named: "traingle")?.resizeImage(targetSize: .init(width: 15, height: 15)).withRenderingMode(.alwaysTemplate), for: .normal)
        self.areaButton.tintColor = .white
        self.areaButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        self.areaButton.titleLabel?.textAlignment = .left
        self.areaButton.layer.cornerRadius = 8
        self.areaButton.showsMenuAsPrimaryAction = true
        self.areaButton.menu = UIMenu(
            title: "",
            children: [
                UIAction(title: "文山") { [weak self] action in self?.setAreaButtonTitle(title: action.title) },
                UIAction(title: "松山") {  [weak self] action in self?.setAreaButtonTitle(title: action.title) },
                UIAction(title: "信義") {  [weak self] action in self?.setAreaButtonTitle(title: action.title)  },
                UIAction(title: "大安") {  [weak self] action in self?.setAreaButtonTitle(title: action.title) },
            ]
        )

    }
    
    func setCountryButtonTitle(title: String) {
        self.countryButton.setTitle(title + "   ", for: .normal)
        self.rowModel?.country = title
    }
    

    func setAreaButtonTitle(title: String) {
        self.areaButton.setTitle(title + "   ", for: .normal)
        self.rowModel?.area = title
    }
    

    
    @objc func textFieldDidEdit(_ sender: UITextField) {
        let text = (self.rowModel?.country ?? "") + (self.rowModel?.area ?? "") + (sender.text ?? "")
        self.rowModel?.textDidChange?(text)
    }
    
}

extension TitleTwoButtonsTextfieldCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? TitleTwoButtonsTextfieldRowModel else { return }
        self.rowModel = rowModel
        self.titleLabel.text = rowModel.title
        self.countryButton.setTitle((rowModel.country ?? "") + "   ", for: .normal)
        self.areaButton.setTitle((rowModel.area ?? "") + "   ", for: .normal)
        
    }
}
