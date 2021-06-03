//
//  ImageLoader.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import Foundation
import Combine

class ImageRequest {
    static func download(url: String) -> AnyPublisher<Data?, Never> {
        guard let imageUrl = URL(string: url) else {
            return Just(nil).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: imageUrl)
            .map { $0.data }
            .replaceError(with: nil)
            .print()
            .eraseToAnyPublisher()
    }
}
