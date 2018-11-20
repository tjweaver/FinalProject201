//
//  ViewController.swift
//  URLSession_JSON
//
//  Created by Haoqin Deng on 11/18/18.
//  Copyright © 2018 CanChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func onGetTapped(_ sender: Any) {
        guard let url=URL(string: "http://localhost:8080/ServerTest/FirstServlet?test=success")else {return}
        
        let session=URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response=response{
                print(response)
            }
            if let data=data{
                print(data)
//                do{
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                }catch{
//                    print(error)
//                }
            }
            
        }.resume()
    }
    
    
    @IBAction func onPostTapped(_ sender: Any) {
        let parameter = ["username":"@canchen","tweet":"hello world"]
        
        guard let url=URL(string: "http://localhost:8080/ServerTest/FirstServlet?test=success")else {return}
        var request = URLRequest(url: url)
        request.httpMethod="POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: [])else{
            return}
        request.httpBody=httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session=URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response=response{
                print(response)
            }
            if let data=data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
}

