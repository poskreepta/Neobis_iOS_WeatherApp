//
//  ViewController.swift
//  WeatherApp
//
//  Created by poskreepta on 22.05.23.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
    private let viewModel: WeatherViewModelType
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(hexString: "#30A2C5").cgColor, UIColor(hexString: "#00242F").cgColor]
        layer.frame = view.bounds
        return layer
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "search"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: Fonts.montserratRegular, size: 14)
        label.textAlignment = .center
        label.text = "Today, May 7th, 2021"
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: Fonts.montserratBold, size: 40)
        label.textAlignment = .center
        label.text = "Barcelona"
        return label
    }()
    
    var countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: Fonts.montserratRegular, size: 20)
        label.textAlignment = .center
        label.text = "Spain"
        return label
    }()
    
    lazy var todayTempView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = hAdapted(to: 240) / 2
        return view
    }()
    
    var mainTempImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "rainImageCenter")
        return iv
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Montserrat-Light", size: 100)
        label.textAlignment = .center
        label.text = "10°C"
        return label
    }()
    
    let windLabel : UILabel = {
        let label = UILabel().configureWeatherParameterName(with: "Wind Status")
        return label
        
    }()
    var windValueLabel : UILabel = {
        let label = UILabel().configureWeatherParameterValue(with: "7 mph")
        return label
    }()
    
    let visibilityLabel : UILabel = {
        let label = UILabel().configureWeatherParameterName(with: "Visibility")
        return label
    }()
    
    var visibilityValueLabel : UILabel = {
        let label = UILabel().configureWeatherParameterValue(with: "6.4 miles")
        return label
    }()
    
    let humidityLabel : UILabel = {
        let label = UILabel().configureWeatherParameterName(with: "Humidity")
        return label
    }()
    
    var humidityValueLabel : UILabel = {
        let label = UILabel().configureWeatherParameterValue(with: "85%")
        return label
    }()
    
    let airPressureLabel : UILabel = {
        let label = UILabel().configureWeatherParameterName(with: "Air Pressure")
        return label
    }()
    
    var airPressureValueLabel : UILabel = {
        let label = UILabel().configureWeatherParameterValue(with: "998 mb")
        return label
    }()
    
    fileprivate let nextweekView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var dateAndPlaceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel,cityLabel,countryLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
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
        setupConstraints()
    }
    
    func setupViews() {
        view.layer.addSublayer(gradientLayer)
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(searchButton)
        view.addSubview(dateAndPlaceStackView)
        view.addSubview(todayTempView)
        view.addSubview(mainTempImageView)
        view.addSubview(tempLabel)
        view.addSubview(windLabel)
        view.addSubview(windValueLabel)
        view.addSubview(humidityLabel)
        view.addSubview(humidityValueLabel)
        view.addSubview(visibilityLabel)
        view.addSubview(visibilityValueLabel)
        view.addSubview(airPressureLabel)
        view.addSubview(airPressureValueLabel)
        view.addSubview(nextweekView)
    }
    
    func setupConstraints() {
        searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(vAdapted(to: 80))
            make.trailing.equalToSuperview().offset(-(hAdapted(to: 30)))
        }
        dateAndPlaceStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(vAdapted(to: 120))
        }
        todayTempView.snp.makeConstraints { make in
            make.top.equalTo(dateAndPlaceStackView.snp.bottom).offset(vAdapted(to: 20))
            make.centerX.equalToSuperview()
            make.width.equalTo(hAdapted(to: 240))
            make.height.equalTo(vAdapted(to: 240))
        }
        mainTempImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(todayTempView.snp.top).offset(vAdapted(to: 5))
            make.width.height.equalTo(vAdapted(to: 50))
        }
        tempLabel.snp.makeConstraints { make in
            make.center.equalTo(todayTempView.snp.center)
        }
        windLabel.snp.makeConstraints { make in
            make.top.equalTo(todayTempView.snp.bottom).offset(vAdapted(to: 30))
            make.leading.equalToSuperview().offset(hAdapted(to: 60))
        }
        windValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(windLabel.snp.centerX)
            make.top.equalTo(windLabel.snp.bottom).offset(vAdapted(to: 5))
        }
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(windValueLabel.snp.bottom).offset(vAdapted(to: 20))
            make.centerX.equalTo(windLabel.snp.centerX)
        }
        humidityValueLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(vAdapted(to: 5))
            make.centerX.equalTo(humidityLabel.snp.centerX)
        }
        visibilityLabel.snp.makeConstraints { make in
            make.top.equalTo(todayTempView.snp.bottom).offset(vAdapted(to: 30))
            make.trailing.equalToSuperview().offset(-(hAdapted(to: 60)))
        }
        visibilityValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(visibilityLabel.snp.centerX)
            make.top.equalTo(visibilityLabel.snp.bottom).offset(vAdapted(to: 5))
        }
        airPressureLabel.snp.makeConstraints { make in
            make.top.equalTo(visibilityValueLabel.snp.bottom).offset(vAdapted(to: 20))
            make.centerX.equalTo(visibilityLabel.snp.centerX)
        }
        airPressureValueLabel.snp.makeConstraints { make in
            make.top.equalTo(airPressureLabel.snp.bottom).offset(vAdapted(to: 5))
            make.centerX.equalTo(airPressureLabel.snp.centerX)
        }
    }
    
    
    @objc private func searchButtonTapped() {
        let searchViewController = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
}

