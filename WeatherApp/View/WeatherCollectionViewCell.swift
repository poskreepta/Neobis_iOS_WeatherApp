//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by poskreepta on 24.06.23.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherCollectionViewCell"
    
    var dayOfTheWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Fonts.montserratMedium, size: 10)
        label.textAlignment = .center
        return label
    }()
    
    var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "#D4D4D4").cgColor
        view.layer.cornerRadius = 17
        return view
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Fonts.montserratRegular, size: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(dayOfTheWeekLabel)
        addSubview(borderView)
        addSubview(imageView)
        addSubview(tempLabel)
    }
    
    private func setupConstraints() {
        dayOfTheWeekLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(dayOfTheWeekLabel.snp.bottom).offset(3)
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.top).offset(10)
            make.height.equalTo(26)
            make.width.equalTo(26)
            make.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func configureWeekWeather(with weekWeather: WeatherWeekModel) {
         dayOfTheWeekLabel.text = weekWeather.day
         tempLabel.text = weekWeather.temp
         imageView.image = UIImage(named: weekWeather.image)
     }
}
