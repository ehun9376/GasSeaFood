//
//  DefaultSuccessModel.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/4/13.
//

import Foundation

class DefaultSuccessModel: JsonModel {
    
    var status: Bool = true
    
    var message: String = ""
    
    required init(json: JBJson) {
        self.status = json["status"].booleanValue
        self.message = json["message"].stringValue
    }
    
}
