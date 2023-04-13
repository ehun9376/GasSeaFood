//
//  APIService.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/8.
//

import Foundation

typealias HTTPHeaderField = [String: String]

typealias parameter = [String: Any]

typealias CompleteAction<T: JsonModel> = ((_ jsonModel: T?,_ error: Error?)->())

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

enum HeaderField {
    
    case json
    
    var field: HTTPHeaderField {
        switch self {
        case .json:
            return [
                "Content-Type" : "application/json"
            ]
        }
    }
}


class APIService: NSObject {
    
    static let shared = APIService()
    
    private let apiQueue = DispatchQueue(label: "api_queue", qos: .utility)

    enum URLText: String {
        case login = "https://deyutest1.com/GasSeaFood/login.php?"
        case regis = "https://deyutest1.com/GasSeaFood/regis.php?"
        case info = "https://deyutest1.com/GasSeaFood/info.php?"
    
        //https://deyutest1.com/GasSeaFood/login1.php?phone=9999&password=9999
        //"https://deyutest1.com/GasSeaFood/regis.php?phone=9999&name=9999&password=1234"
        //https://deyutest1.com/GasSeaFood/info.php?phone=087721016
    }
        
    func requestWithParam<T: JsonModel>(httpMethod: HttpMethod = .post, headerField: HTTPHeaderField? = [:] , urlText: URLText, params: parameter, modelType: T.Type ,  completeAction: @escaping CompleteAction<T>) {
        
        var url = urlText.rawValue
        
        var paramText: [String] = []
        for param in params {
            paramText.append("\(param.key)=\(param.value)")
        }
        let paramTextUrl = paramText.joined(separator: "&")
        url = url + paramTextUrl
        
        
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            
            for header in headerField ?? [:] {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
            

            
            request.httpMethod = httpMethod.rawValue

            
            self.apiQueue.async {
                let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in

                    if let error = error {
                        completeAction(nil, error)
                    } else if let data = data {
                        do {
                            let json = try JBJson(data: data)
                            print(json)
                            completeAction(modelType.init(json: json), error)
                        } catch {
                            completeAction(nil, error)
                        }
                    }
                }

                task.resume()
            }
        }
    }
    
}


