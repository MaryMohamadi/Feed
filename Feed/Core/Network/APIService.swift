//
//  APIService.swift
//  Feed
//
//  Created by Maryam Alimohammadi on 2/14/20.
//  Copyright © 2020 Maryam Alimohammadi. All rights reserved.
//

import UIKit

enum APIError: Error{
    case missingData
}

enum Result<T>{
    case success(T)
    case failure(Error)
}

final class APIService {
    
    static let shared = APIService()
    
    let session = URLSession(configuration: .default)
    
    typealias SerializationFunction<T> = (Data?, URLResponse?, Error?) -> Result<T>
    
    @discardableResult
    private func request<T>(_ url: URL,
                                serializationFunction: @escaping SerializationFunction<T>,
                                complition: @escaping (Result<T>)->Void) -> URLSessionDataTask{
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            let result: Result<T> = serializationFunction(data, response, error)
            DispatchQueue.main.async {
                complition(result)
            }
        }
        
        dataTask.resume()
        return dataTask
    }
    
    @discardableResult
    func request<T:Decodable>(withURL url: URL, completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask{
        return request(url, serializationFunction: serializeJSON, complition: completion)
        
    }
    
    private func serializeJSON<T: Decodable>(with data: Data?, response: URLResponse?, error: Error?) -> Result<T>{
        if let error = error{return .failure(error)}
        guard let data = data else{return .failure(APIError.missingData)}
        do{
            let serializedValue = try JSONDecoder().decode(T.self, from: data)
            return .success(serializedValue)
        }catch{
            return .failure(error)
        }
        
    }
    
    @discardableResult
    func requestImage(withURL url: URL, completion: @escaping (Result<UIImage>) -> Void) -> URLSessionDataTask{
        return request(url, serializationFunction: serializeImage, complition: completion)
        
    }
    
    private func serializeImage(with data: Data?, response: URLResponse?, error: Error?) -> Result<UIImage>{
        
        if let error = error{return .failure(error)}
        guard let data = data, let image = UIImage(data: data) else {
            return .failure(APIError.missingData)
        }
        
        return .success(image)
    }
}
