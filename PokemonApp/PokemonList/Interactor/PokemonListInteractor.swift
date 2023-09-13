//
//  PokemonListInteractor.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//
//
import Foundation
import UIKit

protocol PokemonListInteractorProtocol: AnyObject {

    var pokemons: [Pokemon] { get }
    var nextPokemonsUrl: String? { get }
    var baseUrl: String { get }
    var networkService: NetworkServiceProtocol { get }
    
    func configureViewPokemons(completion: @escaping (Result<Void, Error>) -> Void)
    func fetchNextPokemons(completion: @escaping (Result<Void, Error>) -> Void)
    func fetchNextPokemonsUrl(with url: String, completion: @escaping (Result<Void, Error>) -> Void)
    
}

final class PokemonListInteractor: PokemonListInteractorProtocol {
    
    weak var presenter: PokemonListPresenterProtocol?
    
    var pokemons = [Pokemon]()
    var nextPokemonsUrl: String?
    let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    
    func configureViewPokemons(completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.getData(urlStr: baseUrl, expecting: Response.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.pokemons = response.results
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchNextPokemons(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let nextPokemonsUrl else { return }
        
        networkService.getData(urlStr: nextPokemonsUrl, expecting: Response.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.pokemons.append(contentsOf: response.results)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchNextPokemonsUrl(with url: String, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.getData(urlStr: url, expecting: Response.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.nextPokemonsUrl = response.next
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
