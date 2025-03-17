//
//  ImageFetchingService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.03.2025..
//

import Foundation

class ImageFetchingService {

    static func fetchImage(from imageUrl: URL, completion: @escaping (Data?) -> Void) {

        URLSession.shared.dataTask(with: URLRequest(url: imageUrl)) { data, _, _ in
            if let data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
    }
}
