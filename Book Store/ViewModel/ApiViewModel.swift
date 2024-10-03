//
//  ApiViewModel.swift
//  Book Store
//
//  Created by Apple on 30/09/24.
//

import Foundation
import UIKit

class APIClient {
    func request<T: Codable>(URL_String:String,MethodType:String, modelType: T.Type, parameters: [String: Any],completion: @escaping(T,Int) -> Void) {

        func parseResponse(data: Data, responseCode: Int){
            let Str_data = String(decoding: data, as: UTF8.self)
            print("Response for \(URL_String)", Str_data)
            let decoder = JSONDecoder()
            do{
              let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData, responseCode)
                }
            } catch {
               print(error)
            }
        }
        

        guard let url = URL(string: URL_String) else {return}
        var request = URLRequest(url: url)
        if MethodType == "POST"
        {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let parametersToSend = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            else {
                print("Error")
                return
            }
            request.httpBody = parametersToSend
            let Str_data = String(decoding: request.httpBody!, as: UTF8.self)
            print("Request for POST \(URL_String)", Str_data)
        } else if MethodType == "GET"
        {
            request.httpMethod = "GET"
        } else if MethodType == "PUT" {
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let parametersToSend = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                print("Error")
                return
            }
            request.httpBody = parametersToSend
                        let Str_data = String(decoding: request.httpBody!, as: UTF8.self)
                        print("Request for PUT \(URL_String)", Str_data)
                    }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            
            if let data = data , let httpStatus = response as? HTTPURLResponse{
                parseResponse(data: data, responseCode: httpStatus.statusCode)
            }else{
                print("Error - ",error as Any)
            }
       }.resume()
    }
    
}
