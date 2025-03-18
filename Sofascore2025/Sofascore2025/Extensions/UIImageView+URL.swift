//
//  UIImageView+URL.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 15.03.2025..
//

import UIKit

extension UIImageView {

    func setImageURL(_ url: URL?) {
        guard let url = url else { return }

        ImageFetchingService.fetchImage(from: url) { [weak self] data in
            DispatchQueue.main.async {
                if let data {
                    self?.image = UIImage(data: data)
                } else {
                    self?.image = nil
                }
            }
        }
    }
}
