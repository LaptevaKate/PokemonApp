//
//  HomePagePresenter.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 12.09.23.
//

import UIKit

protocol HomePagePresenterProtocol: AnyObject {
    func configureView()
    func itemSelected()
}

final class HomePagePresenter: HomePagePresenterProtocol {
    
    weak var view: HomePageViewProtocol?
    var interactor: HomePageInteractorProtocol?
    var router: HomePageRouterProtocol?
    
    init(view: HomePageViewProtocol) {
        self.view = view
    }

    func configureView() {
        interactor?.fetchData()
    }
    
    func itemSelected() {
        router?.moveToNext()
    }
}
