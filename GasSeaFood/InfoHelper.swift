//
//  InfoHelper.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/4/13.
//

import Foundation

class InfoHelper: NSObject {
    
    static let shared = InfoHelper()
    
    private var regisModel: RegisModel?
    
    func getRegisModel(reset: Bool = true, cellPhoneNumber: String, complete: ((RegisModel?)->())? = nil) {
        
        if reset {
            self.regisModel = nil
        }
        
        if let regisModel = self.regisModel {
            complete?(regisModel)
        } else {
            let param = [
                "WORKER_PhoneNum": cellPhoneNumber
            ]
            
            APIService.shared.requestWithParam(urlText: .info, params: param, modelType: RegisModel.self) { jsonModel, error in
                if let jsonModel = jsonModel {
                    self.regisModel = jsonModel
                    complete?(self.regisModel)
                }
            }
        }

    }
    
}
