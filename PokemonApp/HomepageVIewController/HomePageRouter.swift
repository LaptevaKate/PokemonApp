//
//  HomePageRouter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import Foundation

protocol HomePageRouterProtocol {
    func moveToNext()
}

final class HomePageRouter: HomePageRouterProtocol {
    
    weak var viewController: HomePageViewProtocol!
    
    init(viewController: HomePageViewProtocol) {
        self.viewController = viewController
    }
    
    func moveToNext() {
        //
    }
}
