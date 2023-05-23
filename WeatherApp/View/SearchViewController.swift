//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by poskreepta on 23.05.23.
//

import UIKit

class SearchViewController: UIViewController {
    
    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        return view
    }()
    
    let searchTextField: CustomTextField = {
       let textfield = CustomTextField()
       textfield.placeholder = "SEARCH LOCATION"
       let attributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
       textfield.attributedPlaceholder = NSAttributedString(string: "SEARCH LOCATION", attributes: attributes as [NSAttributedString.Key : Any])
       textfield.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
       textfield.layer.cornerRadius = 20
       return textfield
   }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
