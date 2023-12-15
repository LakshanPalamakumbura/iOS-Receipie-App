//
//  APICaller.swift
//  Techcess App
//
//  Created by Lakshan Palamakumbura on 2023-12-15.
//

import Foundation


enum APIError: Error {

    case failedTogetData
}


class APICaller {

    static let shared = APICaller()



//    func getUser(completion: @escaping (Result<[Response], Error>)->Void){
//         guard let url = URL(string: "http://127.0.0.1:8000/api/user-details")else {return}
//
//         let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
//             guard let data = data, error == nil else {
//                 return
//                 }
//             do {
//                 let results = try JSONDecoder().decode([Response].self, from: data)
//                 let desert = Array(results.suffix(3))
//                 completion(.success(desert))
//             }catch{
//                 completion(.failure(error))
//             }
//         }
//         task.resume()
//     }

//    func getuserDetail(completion: @escaping (Result<[Response], Error>)->Void){
//         guard let url = URL(string: "http://127.0.0.1:8000/api/user-details")else {return}
//
//         let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
//             guard let data = data, error == nil else {
//                 return
//                 }
//             do {
//                 let results = try JSONDecoder().decode([Response].self, from: data)
////                 print(results)
////                 print(results[0].name)
//
////                 for i in 0..<2 {
////                     print(results[i].name)
////                 }
//                 completion(.success(results))
//             }catch{
//                 completion(.failure(error))
//             }
//         }
//         task.resume()
//     }


//    func getUser(completion: @escaping (Result<[Send], Error>)->Void){
//         guard let url = URL(string: "http://127.0.0.1:8000/api/update-profile")else {return}
//        guard let token = UserDefaults.standard.string(forKey: "token") else {return}
//
//        var request = URLRequest(url: url)
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//         let task = URLSession.shared.dataTask(with: request){data, _, error in
//             guard let data = data, error == nil else {
//                 return
//                 }
////             print("\(String(data: data, encoding: .utf8))")
////             print(token)
//             do {
//                 let results = try JSONDecoder().decode([Send].self, from: data)
//                 completion(.success(results))
//
//             }catch{
//                 completion(.failure(error))
//             }
//         }
//         task.resume()
//     }
}






