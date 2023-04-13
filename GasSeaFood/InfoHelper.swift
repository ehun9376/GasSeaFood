//
//  InfoHelper.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/4/13.
//

import Foundation

class InfoHelper: NSObject {
    
    static let shared = InfoHelper()
    
    var regisModel: RegisModel?
    
    func getRegisModel(cellPhoneNumber: String, complete: ((RegisModel?)->())? = nil) {
        
        let param = [
            "phone": cellPhoneNumber
        ]
        
        APIService.shared.requestWithParam(urlText: .info, params: param, modelType: RegisModel.self) { jsonModel, error in
            if let jsonModel = jsonModel {
                self.regisModel = jsonModel
                complete?(self.regisModel)
            }
        }
    }
    
}
