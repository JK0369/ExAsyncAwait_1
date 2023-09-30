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
//        Task {
            let image = try await loadImage(url: url)
//        }
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
