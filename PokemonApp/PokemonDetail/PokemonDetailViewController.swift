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
    
    func setUpPokemonInfo(with pokemon: PokemonDetail, data: Data)
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
        setupUI()
        presenter?.pokemonViewDidLoaded()
        
    }
    
    // MARK: - Methods
    
    
    func setUpPokemonInfo(with pokemon: PokemonDetail, data: Data) {
        
        DispatchQueue.main.async {
            self.pokemonImageView.image = UIImage(data: data)
            self.pokemonNameLabel.text = "Types: " + pokemon.types.map{$0.type.name}.joined(separator: ", ")
            self.pokemonTypeLabel.text = "Height: \(pokemon.height * 10) cm"
            self.pokemonWeightLabel.text = "Weight: \(pokemon.weight / 10) kg"
            self.pokemonHeightLabel.text = pokemon.name.capitalized
        }
    }
    
}
// MARK: - extension -  UI
private extension PokemonDetailViewController {
    func setupUI() {
        navigationItem.title = "Pokemon Info"
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
