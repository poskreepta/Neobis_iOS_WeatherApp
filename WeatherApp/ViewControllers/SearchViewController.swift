//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by poskreepta on 23.06.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
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
        searchView.searchButton.rx.tap
                  .withLatestFrom(searchView.searchTextField.rx.text.orEmpty)
                  .subscribe(onNext: { [weak self] city in
                      self?.viewModel.fetchWeatherData(city: city)
                      self?.viewModel.fetchWeatherWeekData(city: city)
                      self?.dismiss(animated: true, completion: nil)
                  })
                  .disposed(by: disposeBag)
    }
    
    func setupViews() {
        searchView.gradientLayer.frame = view.bounds
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
