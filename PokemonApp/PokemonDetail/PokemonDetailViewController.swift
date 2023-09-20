//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 13.09.23.
//

import UIKit
import RealmSwift

protocol PokemonDetailViewProtocol: AnyObject {
    
    var presenter: PokemonDetailPresenterProtocol? { get set }
    func setupUI(with viewModel: PokemonDetailViewModel)
    func showError(_ error: Error)
}

final class PokemonDetailViewController: UIViewController, PokemonDetailViewProtocol {
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pokemonNameLabel, pokemonImageView, pokemonTypeLabel,pokemonWeightLabel, pokemonHeightLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()
    
    private let pokemonNameLabel = UILabel()
    private let pokemonTypeLabel = UILabel()
    private let pokemonWeightLabel = UILabel()
    private let pokemonHeightLabel = UILabel()
    
    // MARK: - Properties
    var presenter: PokemonDetailPresenterProtocol?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialsetupUI()
        presenter?.pokemonViewDidLoad()
        
    }
    // MARK: - Methods
    func showError(_ error: Error) {
        AlertPresenter.showAlert(message: error.localizedDescription, on: self)
    }
}
// MARK: - extension -  UI
extension PokemonDetailViewController {
    private func initialsetupUI() {
        navigationItem.title = "Pokemon Info"
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    func setupUI(with viewModel: PokemonDetailViewModel) {
        self.pokemonImageView.image = viewModel.pokemonImage
        self.pokemonNameLabel.text = viewModel.pokemonName
        self.pokemonTypeLabel.text = viewModel.pokemonType
        self.pokemonWeightLabel.text = viewModel.pokemonWeight
        self.pokemonHeightLabel.text = viewModel.pokemonHeight
    }
}
