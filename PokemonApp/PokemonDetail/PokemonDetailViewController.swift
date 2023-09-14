//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by Екатерина Лаптева on 13.09.23.
//

import UIKit

protocol PokemonDetailViewProtocol: AnyObject {
    
    var presenter: PokemonDetailPresenterProtocol? { get set }
    
    func setUpPokemonInfo(with pokemon: PokemonDetail, data: Data, names: [String])
}


final class PokemonDetailViewController: UIViewController, PokemonDetailViewProtocol {
    
    // MARK: - Properties
    var presenter: PokemonDetailPresenterProtocol?
    private var pokemonDetail: [PokemonDetail]?
    
    private let pokemonNameLabel = UILabel()
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let pokemonTypeLabel = UILabel()
    private let pokemonWeightLabel = UILabel()
    private let pokemonHeightLabel = UILabel()
    
    private var stackView = UIStackView()
    
   
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.pokemonViewDidLoaded()
        
    }
 
    // MARK: - Methods

    func setUpPokemonInfo(with pokemon: PokemonDetail, data: Data, names: [String]) {
        
        DispatchQueue.main.async {
            self.pokemonImageView.image = UIImage(data: data)
            self.pokemonNameLabel.text = "Types: " + names.joined(separator: ", ")
            self.pokemonTypeLabel.text = "Height: \(pokemon.height * 10) cm"
            self.pokemonWeightLabel.text = "Weight: \(pokemon.weight / 10) kg"
            self.pokemonHeightLabel.text = pokemon.name.capitalized
        }
    }
}
// MARK: - extension -  UI
private extension PokemonDetailViewController {
    func setupUI() {
      
        stackView = UIStackView(arrangedSubviews: [pokemonNameLabel, pokemonImageView, pokemonTypeLabel,pokemonWeightLabel, pokemonHeightLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = UIStackView.spacingUseSystem
        view.addSubview(stackView)
    }
}
