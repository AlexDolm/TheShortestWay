//
//  ViewController.swift
//  TheShortestWay
//
//  Created by mac on 23.05.2022.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let addAdressButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("+ адрес", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let routeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Поиск пути", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Заново", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
        addAdressButton.addTarget(
            self, action: #selector(addAdressButtonTapped) , for: .touchUpInside)
        
        routeButton.addTarget(
            self, action: #selector(routeButtonTapped) , for: .touchUpInside)
        
        resetButton.addTarget(
            self, action: #selector(resetButtonTapped) , for: .touchUpInside)
        
    }
    
    @objc func addAdressButtonTapped(){
        alertAddAdress(title: "Добавить", placeholder: "Введите адрес"){ (text) in
            print(text)

        }
        alertError(title: "Ошибка", message: "ав")
    }
    @objc func routeButtonTapped(){
        print("Нажали2")
        
    }
    @objc func resetButtonTapped(){
        print("Нажали3")
        
    }
    
    


}

extension ViewController {
    func setConstraints()
    {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant:  0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  0),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor, constant:  0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  0)
        ])
        
        mapView.addSubview(addAdressButton)
        NSLayoutConstraint.activate([
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant:  50),
            addAdressButton.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -20),
            addAdressButton.heightAnchor.constraint(equalToConstant: 50),
            addAdressButton.widthAnchor.constraint(equalToConstant: 100)
            
            
        ])
        
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant:  -100),
            routeButton.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            routeButton.heightAnchor.constraint(equalToConstant: 50),
            routeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant:  50),
            resetButton.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 20),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }

}

