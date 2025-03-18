//
//  ImageFetchingService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.03.2025..
//

import Foundation

class ImageFetchingService {

    static func fetchImage(from url: URL, completion: @escaping (Data?) -> Void) {

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let error {
                print("ImageFetchingService error: \(error)")
            }

            completion(data)
        }.resume()
    }
}
