//
//  ViewController.swift
//  WeatherApp
//
//  Created by poskreepta on 22.05.23.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
    let cellId = "cellId"
    
    private var viewModel: WeatherViewModelType
    
    var nextWeek = [
        WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 1), temp: "8°C", image: "snowImage"),
        WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 2), temp: "3°C", image: "rainSunImage"),
        WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 3), temp: "5°C", image: "hailImage"),
        WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 4), temp: "9°C", image: "thunderImage"),
        WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 5), temp: "5°C", image: "cloudyImage")]
    
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
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
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
        cvv.dataSource = self
        cvv.delegate = self
        cvv.translatesAutoresizingMaskIntoConstraints = false
        return cvv
    }()
    
    init(viewModel: WeatherViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.modelDidChange = { [weak self] in
            self?.updateUI(with: self?.viewModel.model ?? WeatherModel())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        weatherTodayCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
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
        view.addSubview(nextFiveDaysLabel)
        view.addSubview(weatherTodayCollectionView)
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
    
    @objc private func searchButtonTapped() {
        let searchViewController = SearchViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: searchViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    //MARK: - updateUI
    private func updateUI(with model: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = self.viewModel.model.cityName
            self.tempLabel.text = self.viewModel.model.tempratureString
            self.mainTempImageView.image = UIImageView(image: UIImage(systemName: self.viewModel.model.conditionName)).image
            self.humidityValueLabel.text = self.viewModel.model.humidityString
            self.windValueLabel.text = self.viewModel.model.windStatusString
            self.visibilityValueLabel.text = self.viewModel.model.visibilityString
            self.airPressureValueLabel.text = self.viewModel.model.airPressureString
            self.countryLabel.text = self.viewModel.model.countryString
            self.dateLabel.text = "Today, \(DateToStringFormat.shared.currentDate())"
            self.nextWeek = [
                WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 1), temp: self.viewModel.model.temp1String, image: self.viewModel.model.conditionName1),
                WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 2), temp: self.viewModel.model.temp2String, image: self.viewModel.model.conditionName2),
                WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 3), temp: self.viewModel.model.temp3String, image: self.viewModel.model.conditionName3),
                WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 4), temp: self.viewModel.model.temp4String, image: self.viewModel.model.conditionName4),
                WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 5), temp: self.viewModel.model.temp5String, image: self.viewModel.model.conditionName5)]
            self.weatherTodayCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nextWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? WeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        DispatchQueue.main.async {
            cell.tempLabel.text = self.nextWeek[indexPath.item].temp
            cell.dayOfTheWeekLabel.text = self.nextWeek[indexPath.item].day
            cell.imageView.image = UIImage(named: self.nextWeek[indexPath.item].image)
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

