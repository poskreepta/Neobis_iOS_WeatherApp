//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by poskreepta on 23.05.23.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private let viewModel: WeatherViewModelType
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(hexString: "#30A2C5").cgColor, UIColor(hexString: "#00242F").cgColor]
        layer.frame = view.bounds
        return layer
    }()
    
    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        return view
    }()
    
    let searchTextField: UITextField = {
       let textField = UITextField()
       textField.placeholder = "SEARCH LOCATION"
        textField.font = UIFont(name: Fonts.montserratRegular, size: 14)
        textField.textColor = .black
       textField.backgroundColor = UIColor(hexString: "#EDEDED")
       textField.layer.cornerRadius = 20
       return textField
   }()
    
    lazy var searchButton: UIButton = {
       let button = UIButton(type: .system)
       button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratMedium, size: 14)
        button.backgroundColor = .white
       button.tintColor = .black
       button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(searchCityButtonTapped), for: .touchUpInside)
       return button
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
        view.addSubview(whiteView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        whiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(vAdapted(to: 70))
            make.width.equalToSuperview()
            make.height.equalTo(vAdapted(to: 350))
        }

        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.top).offset(vAdapted(to: 80))
            make.width.equalTo(hAdapted(to: 300))
            make.height.equalTo(vAdapted(to: 50))
            make.centerX.equalToSuperview()
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(vAdapted(to: 30))
            make.width.equalTo(hAdapted(to: 150))
        }
    }
    
    @objc func searchCityButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        viewModel.fetchWeatherData(city: searchTextField.text ?? "")
        viewModel.fetchWeatherWeekData(city: searchTextField.text ?? "")
    }
}
