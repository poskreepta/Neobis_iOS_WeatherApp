//
//  ViewController.swift
//  WeatherApp
//
//  Created by poskreepta on 22.06.23.
//

import UIKit
import SnapKit
import CoreLocation

class MainWeatherViewController: UIViewController {
        
    private var viewModel: WeatherViewModelType
    private var mainWeatherView = MainWeatherView()
    private var locationManager = CLLocationManager()
  
    init(viewModel: WeatherViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.modelDidChange = { [weak self] in
            self?.updateUI()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        mainWeatherView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        mainWeatherView.weatherTodayCollectionView.delegate = self
        mainWeatherView.weatherTodayCollectionView.dataSource = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
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
    
    //MARK: - updateUI
    private func updateUI() {
        DispatchQueue.main.async {
            if let weatherData = self.viewModel.weatherData {
                self.mainWeatherView.configure(with: weatherData)
                  }
            self.mainWeatherView.weatherTodayCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension MainWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let nextWeekData = self.viewModel.nextWeekData else {
                  return 0
              }
              return nextWeekData.nextWeekArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        DispatchQueue.main.async {
            if let weatherWeekData = self.viewModel.nextWeekData {
                cell.configureWeekWeather(with: weatherWeekData, at: indexPath)
                  }
        }
        return cell
    }
    
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

//MARK: - CLLocationManagerDelegate

extension MainWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            viewModel.fetchWeatherWithLocation(latitude: lat, longitude: lon)
            viewModel.fetchWeekWeatherWithLocation(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}

