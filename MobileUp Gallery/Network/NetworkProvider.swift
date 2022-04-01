//
//  NetworkProvider.swift
//  MobileUp Gallery
//
//  Created by Михаил on 28.03.2022.
//

import Foundation

struct NetworkImageManager {
    
    let authService: AuthService = .shared
    
    private let baseUrlString = "https://api.vk.com"
    
    func fetchImages(result: @escaping (Result<[Information], Error>) -> Void) {
        let photosGet = URLComponents(string: baseUrlString + "/method/photos.get")
        guard let token = authService.token, var urlComponent = photosGet else {
            let error = NSError(domain: "fetchCurrentImage", code: -1, userInfo: [:])
            result(.failure(error))
            return
        }
        let queryItems = [
            URLQueryItem(name: "owner_id", value: "-128666765"),
            URLQueryItem(name: "album_id", value: "266276915"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.131"),
        ]
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else {
            let error = NSError(domain: "fetchCurrentImage", code: -1, userInfo: [:])
            result(.failure(error))
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let images = try decoder.decode(DataResponce.self, from: data)
                    result(.success(images.response.items))
                } catch let error as NSError {
                    result(.failure(error))
                }
            } else {
                let error = error ?? NSError(domain: "fetchCurrentImage", code: -1, userInfo: [:])
                result(.failure(error))
            }
        }
        task.resume()
    }
}
