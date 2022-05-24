//
//  ViewController.swift
//  TheShortestWay
//
//  Created by mac on 23.05.2022!
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
    
    var annotationsArray = [MKPointAnnotation]()

    override func viewDidLoad() {
        
        mapView.delegate = self
        
        super.viewDidLoad()
        setConstraints()
        
        addAdressButton.addTarget(
            self, action: #selector(addAdressButtonTapped) , for: .touchUpInside)
        
        routeButton.addTarget(
            self, action: #selector(routeButtonTapped) , for: .touchUpInside)
        
        resetButton.addTarget(
            self, action: #selector(resetButtonTapped) , for: .touchUpInside)
        
    }
    
    @objc func addAdressButtonTapped(){ //adding points
        alertAddAdress(title: "Добавить", placeholder: "Введите адрес"){ (text) in
            print(text)
            self.setupPlacemark(adressPlace: text)

        }
        alertError(title: "Ошибка", message: "ав")
    }
    @objc func routeButtonTapped(){ //building paths from point to point
        for index in 0...annotationsArray.count-2 {
            createDirectionRequest(startCoordinate: annotationsArray[index].coordinate, destinationCoordinate: annotationsArray[index+1].coordinate)
            
        }
        
        mapView.showAnnotations(annotationsArray, animated: true)
        
        
        
    }
    @objc func resetButtonTapped(){ //clearing the map
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationsArray = [MKPointAnnotation]()
        routeButton.isHidden = true
        resetButton.isHidden = true
        
    }
    
    
    private func setupPlacemark(adressPlace:String){ // add an annotation to the map at the address
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adressPlace) { placemarks, error in
            if let error = error {
                self.alertError(title: "Ошибка", message: "Сервер недоступен.")
                return
            }
            
            guard let placemarks = placemarks else {return}
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(adressPlace)"
            guard let placemarkLocation = placemark?.location else {return}
            annotation.coordinate = placemarkLocation.coordinate
            
            self.annotationsArray.append(annotation)
            
            if self.annotationsArray.count > 2 {
                self.routeButton.isHidden = false
                self.resetButton.isHidden = false
            }
            
            self.mapView.showAnnotations(self.annotationsArray, animated: true)
            
        }
    }
    
    //building a route
    private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D ){
        
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        
        let diraction = MKDirections(request: request)
        diraction.calculate { (responce, error) in
            if let error = error {return}
            guard let responce = responce else {
                self.alertError(title: "Ошибка", message: "Маршрута несуществует")
                return
            }
            
            var minRoute = responce.routes[0]
            for route in responce.routes {
                print("погнали")
                print(route.distance)
                if route.distance < minRoute.distance{
                    minRoute = route
                }
                
                self.mapView.addOverlay(minRoute.polyline)
                
            }
        }
        
    }
    


}
extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
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

