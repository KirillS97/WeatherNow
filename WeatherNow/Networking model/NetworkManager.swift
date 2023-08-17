//
//  NetworkManager.swift
//  WeatherNow
//
//  Created by Kirill on 30.07.2023.
//

import Foundation
import Alamofire



class NetwokManager {
    static let shared: NetwokManager = NetwokManager(); private init() {}
    
    
    
    // MARK: - Метод для отправки GET-запроса на сервер; десериализации данных, полученных в ответе от сервера и вызова замыкания, обрабатывающего полученный ответ
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func fetchData(url: URL?, completionHandler: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard let safeUrl = url else {
            DispatchQueue.main.async { completionHandler(.failure(.invalidURL)) }
            return
        }
        let urlRequest: DataRequest = AF.request(safeUrl)
        
        urlRequest.response { (response: AFDataResponse<Data?>) -> Void in
            guard (response.error == nil) else {
                DispatchQueue.main.async { completionHandler(.failure(.errorFromServer)) }
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                DispatchQueue.main.async { completionHandler(.failure(.noStatusCode)) }
                return
            }
            
            guard (200..<300).contains(response.response!.statusCode) else {
                DispatchQueue.main.async { completionHandler(.failure(.errorStatusCode(statusCode: statusCode))) }
                return
            }
            guard let safeData = response.data else {
                DispatchQueue.main.async { completionHandler(.failure(.noData)) }
                return
            }
            
            // Десериализация данных
            let jsonDecor = JSONDecoder()
            guard let decodedData = try? jsonDecor.decode(Weather.self, from: safeData) else {
                DispatchQueue.main.async { completionHandler(.failure(.dataWasNotDecoded)) }
                return
            }
            DispatchQueue.main.async {
                completionHandler(.success(decodedData))
            }
        }
        
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
}
