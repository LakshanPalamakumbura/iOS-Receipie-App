//
//  APICaller.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2023-01-27.
//

import Foundation


enum APIError: Error {
    
    case failedTogetData
}


class APICaller {
    
    static let shared = APICaller()
    
//    func getBreakfast(completion: @escaping (Result<[Response], Error>) -> Void) {
//
//        guard let url = URL(string: "http://127.0.0.1:8000/api/food") else {return}
//
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in guard let data = data, error == nil else{
//                return
//            }
//
//            do {
////                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
////                print(results)
//
////                let results = try JSONDecoder().decode([Response].self, from: data)
////                completion(.success(results))
//
////                print(results)
//                let results = try JSONDecoder().decode(Response.self, from: data)
//                print(results)
////                completion(.success(results.data))
//
//            } catch {
//                completion(.failure(APIError.failedTogetData))
//
////                print(error.localizedDescription)
//            }
//
//        }
//        task.resume()
//    }
    
    func getBreakfast(completion: @escaping (Result<[Response], Error>)->Void){
         guard let url = URL(string: "http://127.0.0.1:8000/api/food")else {return}
         
         let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
             guard let data = data, error == nil else {
                 return
                 }
             do {
                 let results = try JSONDecoder().decode([Response].self, from: data)
//                 print(results)
//                 print(results[0].name)
                 
//                 for i in 0..<results.count {
//                     print(results[i].name)
//                 }
                 completion(.success(results))
             }catch{
                 completion(.failure(error))
             }
         }
         task.resume()
     }

    func getMain(completion: @escaping (Result<[Response], Error>)->Void){
         guard let url = URL(string: "http://127.0.0.1:8000/api/food")else {return}

         let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
             guard let data = data, error == nil else {
                 return
                 }
             do {
                 let results = try JSONDecoder().decode([Response].self, from: data)
//                 print(results)
//                 print(results[0].name)

//                 for i in 0..<results.count {
//                     print(results[i].name)
//                 }
                
                 completion(.success(results))
                                
             }catch{
                 completion(.failure(error))
             }
         }
         task.resume()
     }

    func getDessart(completion: @escaping (Result<[Response], Error>)->Void){
         guard let url = URL(string: "http://127.0.0.1:8000/api/food")else {return}

         let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
             guard let data = data, error == nil else {
                 return
                 }
             do {
                 let results = try JSONDecoder().decode([Response].self, from: data)
//                 print(results)
//                 print(results[0].name)

//                 for i in 0..<results.count {
//                     print(results[i].name)
//                 }
                 completion(.success(results))
             }catch{
                 completion(.failure(error))
             }
         }
         task.resume()
     }


    
}






