//
//  UIImageView+URL.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 15.03.2025..
//

import UIKit

extension UIImageView {

    func setImageURL(_ url: String?) {
        guard let url = url else { return }

        ImageFetchingService.fetchImage(from: url) { [weak self] data in
            if let data {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
}
