//
//  HomePageInteractor.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation

protocol HomePageInteractorProtocol: AnyObject {
    func fetchData()
}

final class HomePageInteractor: HomePageInteractorProtocol {
    
    weak var presenter: HomePagePresenterProtocol?
    
    init(presenter: HomePagePresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchData() {
        //
    }
}
