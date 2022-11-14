//
//  CardImageView.swift
//  MTG_all_in_one
//
//  Created by Maxim Mitin on 14.11.22.
//

import UIKit

class CardImageView: UIImageView {
    
    func fetchImage(from url: String) {
        
        guard let imageURL = URL(string: url) else {return}
//        else {
//            let url = URL(string: "https://preview.redd.it/fr7g5swymhc41.png?width=640&crop=smart&auto=webp&s=930c8edaa0acc0755c71c3d737840d08a9e9a0b0")!
//            let data = try? Data(contentsOf: url)
//            image = UIImage(data: data!)
//            return }
        
        //use from cache
        if let cachedImage = getCachedImage(from: imageURL) {
            image = cachedImage
            return
        }
        
        //load image
        ImageManager.shared.fetchImage(from: imageURL) { data, response in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            //Save image to cache
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let urlResponse = response.url else {return}
        let request = URLRequest(url: urlResponse)
        
        let cacheResponse = CachedURLResponse(response: response, data: data)
        
        URLCache.shared.storeCachedResponse(cacheResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
