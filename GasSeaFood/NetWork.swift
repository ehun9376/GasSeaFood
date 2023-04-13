//
//  NetWork.swift
//  GasSeaFood
//
//  Created by yihuang on 2023/2/25.
//

import Foundation

class NetWork {
    
//https://deyutest1.com/GasSeaFood/login1.php?phone=9999&password=9999
//"https://deyutest1.com/GasSeaFood/regis.php?phone=9999&name=9999&password=1234"
    func dataTask() {
        let url = URL(string: "https://deyutest1.com/GasSeaFood/login1.php?phone=9999&password=99998")
        if let url = url {
            URLSession.shared.dataTask(with: .init(url: url)) { data, respond, error in
                guard let data = data else {
                    return
                }
                
                do {
                    if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(dictionary)
                    }
                } catch {
                }
            }.resume()
        }

    }
}
