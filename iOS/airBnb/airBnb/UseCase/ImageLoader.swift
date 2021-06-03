//
//  ImageLoader.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/06/03.
//

import Foundation
import Combine

class ImageLoader {
    
    private let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    
    func load(url: String) -> AnyPublisher<String, Never> {
        guard let fileName = URL(string: url)?.lastPathComponent else {
            return Just("").eraseToAnyPublisher()
        }
        
        let expectedPath = cacheURL.path + "/\(fileName)"
        if checkFile(s: expectedPath) {
            return Just(expectedPath).eraseToAnyPublisher()
        }
        let file = cacheURL.appendingPathComponent(fileName)
        
        return ImageRequest.download(url: url)
            .map { data -> String in
                FileManager.default.createFile(atPath: file.path, contents: data, attributes: nil)
                return expectedPath
            }.eraseToAnyPublisher()
    }
    
    private func checkFile(s: String) -> Bool {
        return FileManager.default.fileExists(atPath: s)
    }
}
