//
//  ViewController.swift
//  ExAsyncAwait
//
//  Created by 김종권 on 2023/09/30.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrlString = "https://images.dog.ceo/breeds/australian-shepherd/pepper.jpg"
        guard let url = URL(string: imageUrlString) else { return }
        Task {
            let image1 = try await loadImage(url: url)
            // wait for loading image...
            let image2 = try await loadImage(url: url)
            let image3 = try await loadImage(url: url)
            let image4 = try await loadImage(url: url)
            
            try await imagesForConcurrency()
        }
    }
    
    func imagesForConcurrency() async throws -> [UIImage] {
        let imageUrlString = "https://images.dog.ceo/breeds/australian-shepherd/pepper.jpg"
        guard let url = URL(string: imageUrlString) else { return [] }
        
        async let first = loadImage(url: url)
        // no wait for loading image
        async let second = loadImage(url: url)
        async let third = loadImage(url: url)
        return try await [first, second, third]
    }
}



func loadImage(url: URL) async throws -> UIImage {
    let (data, _) = try await URLSession.shared.data(from: url)
    if let image = UIImage(data: data) {
        return image
    } else {
        throw NSError(domain: "ImageErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load image"])
    }
}
