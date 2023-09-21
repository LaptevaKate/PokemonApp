//
//  PokemonListInteractorTests.swift
//  PokemonAppTest
//
//  Created by Екатерина Лаптева on 21.09.23.
//

import XCTest
@testable import PokemonApp
import RealmSwift

final class PokemonListInteractorTests: XCTestCase {
    
    final class MockNetworkService: NetworkServiceProtocol {
        func getData<T>(urlString: String, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
            guard let url = URL(string: urlString),
                  let data = try? Data(contentsOf: url),
                  let result = try? JSONDecoder().decode(expecting, from: data)
            else { completion(.failure(NSError()))
                return }
            completion(.success(result))
        }
    }
    
    final class MockPokemonListInteractor: PokemonListInteractorProtocolInput {
        let networkService: NetworkServiceProtocol = MockNetworkService()
        var output: PokemonListInteractorProtocolOutput?
        let fakePokemonUrlString = Bundle(for: PokemonListInteractorTests.self).url(forResource: "FakePokemonData", withExtension: "json")?.absoluteString ?? ""
        func fetchPokemons() {
            networkService.getData(urlString: fakePokemonUrlString, expecting: PokemonData.self) { [weak self] result in
                switch result {
                case .success(let pokemonData):
                    RealmManager.manager.add(pokemonData)
                    self?.output?.pokemonsDidFetch()
                case .failure(let error):
                    self?.output?.pokemonFetchDidFinishWithError(error)
                }
            }
        }
    }
    
    var sut: MockPokemonListInteractor!
    
    override func setUp() {
        setupPokemonListInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupPokemonListInteractor() {
        sut = MockPokemonListInteractor()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    final class MockPokemonListPresenter: PokemonListPresenterProtocol, PokemonListInteractorProtocolOutput {
        weak var view: PokemonListViewProtocol?
        
        var pokemonViewLoadedCalled = false
        var pokemonSelectedCalled = false
        var pokemonDidFetch = false
        
        func pokemonViewLoaded() {
            pokemonViewLoadedCalled = true
        }
        
        func pokemonSelected(_ pokemon: Pokemon, on view: UIViewController) {
            pokemonSelectedCalled = true
        }
        
        func pokemonsDidFetch() {
            pokemonDidFetch = true
        }
        
        func pokemonFetchDidFinishWithError(_ error: Error) {
            view?.showError(error)
        }
    }
    
    func testFetchPokemons() {
        
        let spy = MockPokemonListPresenter()
        let viewController = PokemonListViewController()
        viewController.presenter = spy
        spy.view = viewController
        sut.output = spy
        sut.fetchPokemons()
        
        wait(interval: 1) {
            XCTAssertTrue(spy.pokemonDidFetch, "fetchPokemons() should ask the presenter to format the result")
        }
    }
}

extension XCTestCase {
    func wait(interval: TimeInterval = 0.1 , completion: @escaping (() -> Void)) {
        let exp = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
            exp.fulfill()
        }
        waitForExpectations(timeout: interval + 0.1)
    }
}
