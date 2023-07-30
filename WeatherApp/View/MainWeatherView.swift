//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by poskreepta on 25.07.23.
//

import UIKit
import SnapKit

class MainWeatherView: UIView {

    var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(hexString: "#30A2C5").cgColor, UIColor(hexString: "#00242F").cgColor]
        return layer
    }()
    
    var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "search"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Fonts.montserratRegular, size: 14)
        label.textAlignment = .center
        label.text = "Today, May 7th, 2021"
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Fonts.montserratBold, size: 40)
        label.textAlignment = .center
        label.text = "Barcelona"
        return label
    }()
    
    var countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rainImageCenter")
        return imageView
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Fonts.montserratLight, size: 100)
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
    
    let nextweekView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 60
        return view
    }()
    
    let nextFiveDaysLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Fonts.montserratBold, size: 14)
        label.textAlignment = .center
        label.text = "The Next 5 days"
        return label
    }()
    
    lazy var dateAndPlaceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel,cityLabel,countryLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var weatherTodayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cvv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cvv.translatesAutoresizingMaskIntoConstraints = false
        return cvv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        addSubview(searchButton, dateAndPlaceStackView, todayTempView, mainTempImageView, tempLabel, windLabel, windValueLabel, humidityLabel, humidityValueLabel, visibilityLabel, visibilityValueLabel, airPressureLabel, airPressureValueLabel, nextweekView, nextFiveDaysLabel, weatherTodayCollectionView)
        weatherTodayCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
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
            make.leading.equalToSuperview().offset(hAdapted(to: 30))
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
        nextweekView.snp.makeConstraints { make in
            make.top.equalTo(airPressureValueLabel.snp.bottom).offset(vAdapted(to: 30))
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        nextFiveDaysLabel.snp.makeConstraints { make in
            make.top.equalTo(nextweekView.snp.top).offset(vAdapted(to: 50))
            make.leading.equalToSuperview().offset(hAdapted(to: 30))
        }
        weatherTodayCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nextFiveDaysLabel.snp.bottom).offset(vAdapted(to: 10))
            make.leading.equalToSuperview().offset(hAdapted(to: 20))
            make.trailing.equalToSuperview().offset(hAdapted(to: -20))
            make.height.equalTo(90)
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(with weather: WeatherData?) {
        guard let weather = weather else { return }
        cityLabel.text = weather.cityName
        tempLabel.text = weather.tempratureString
        countryLabel.text = weather.sys.country
        dateLabel.text = DateToStringFormat.shared.currentDate()
        mainTempImageView.image = UIImageView(image: UIImage(systemName: weather.conditionName)).image
        humidityValueLabel.text = weather.humidityString
        windValueLabel.text = weather.windStatusString
        visibilityValueLabel.text = weather.visibilityString
        airPressureValueLabel.text = weather.airPressureString
    }
    

  
}
