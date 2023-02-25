//
//  NetWork.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/25.
//

import Foundation

class NetWork {
    func dataTask() {
        let url = URL(string: "www.google.con.tw")
        if let url = url {
            URLSession.shared.dataTask(with: .init(url: url)) { data, respond, error in
                
            }
        }

    }
}
