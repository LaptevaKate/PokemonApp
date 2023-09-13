//
//  NetworkService.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 13.09.23.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData<T:Decodable>(urlStr: String, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func getData<T:Decodable>(urlStr: String, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = expecting is Data.Type
                    ? data as! T
                    : try JSONDecoder().decode(expecting, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
