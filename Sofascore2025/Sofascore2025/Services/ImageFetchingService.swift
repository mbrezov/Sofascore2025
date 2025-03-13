//
//  ImageFetchingService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.03.2025..
//

import Foundation

class ImageFetchingService {

    static func fetchImage(from imageUrl: String?, completion: @escaping (Data?) -> Void) {
        guard let imageUrl, let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
            if let data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
    }
}
