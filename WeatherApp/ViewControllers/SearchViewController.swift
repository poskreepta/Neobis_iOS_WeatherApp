//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by poskreepta on 23.06.23.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private let viewModel: WeatherViewModelType
    private var searchView = SearchView()
    
    init(viewModel: WeatherViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        searchView.searchButton.addTarget(self, action: #selector(searchCityButtonTapped), for: .touchUpInside)
    }
    
    func setupViews() {
        searchView.gradientLayer.frame = view.bounds
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func searchCityButtonTapped() {
        if let city = searchView.searchTextField.text {
               viewModel.fetchWeatherData(city: city)
               viewModel.fetchWeatherWeekData(city: city)
           }
        self.dismiss(animated: true, completion: nil)
    }
}
