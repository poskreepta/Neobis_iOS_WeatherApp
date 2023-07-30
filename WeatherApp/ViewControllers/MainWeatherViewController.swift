//
//  ViewController.swift
//  WeatherApp
//
//  Created by poskreepta on 22.06.23.
//

import UIKit
import SnapKit
import CoreLocation
import RxSwift
import RxCocoa

class MainWeatherViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: WeatherViewModelType
    private var mainWeatherView = MainWeatherView()
    private var locationManager = CLLocationManager()
    
    init(viewModel: WeatherViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.weatherData
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] weatherData in
                self?.mainWeatherView.configure(with: weatherData)
            }.disposed(by: disposeBag)
        
        self.viewModel.nextWeekData
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.mainWeatherView.weatherTodayCollectionView.reloadData()
            }.disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        mainWeatherView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        setupLocationManager()
        bindCollectionView()
    }
    
    func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainWeatherView.searchButton)
        view.addSubview(mainWeatherView)
        mainWeatherView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func searchButtonTapped() {
        let searchViewController = SearchViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: searchViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    func bindCollectionView() {
        mainWeatherView.weatherTodayCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.nextWeekData
            .map { $0?.nextWeekArray ?? [] }
            .asDriver(onErrorJustReturn: [])
            .drive(mainWeatherView.weatherTodayCollectionView.rx.items(cellIdentifier: WeatherCollectionViewCell.identifier, cellType: WeatherCollectionViewCell.self)) { (_, weatherWeekModel, cell) in
                cell.configureWeekWeather(with: weatherWeekModel)
            }.disposed(by: disposeBag)
    }
    
    func setupLocationManager() {
        LocationManager.shared.getCurrentLocation()
            .subscribe(onNext: { [weak self] location in
                self?.viewModel.fetchWeatherWithLocation(latitude: location.latitude, longitude: location.longitude)
                self?.viewModel.fetchWeekWeatherWithLocation(latitude: location.latitude, longitude: location.longitude)
            }, onError: { error in
                print("Location error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension MainWeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return resized(width: collectionView.frame.width/5 - 7, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return edgeInsets
    }
}


