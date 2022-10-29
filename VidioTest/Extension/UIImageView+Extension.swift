//
//  UIImageView+Extension.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString else {
            return
        }

        loadImage(from: URL(string: urlString))
    }
    
    private func loadImage(from url: URL?, placeholder: UIImage? = nil) {
        guard let url = url else {
            return
        }

        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
            }
        }
    }
}
