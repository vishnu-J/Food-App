//
//  ViewController.swift
//  PartyOne
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var restaurantTableView: UITableView!
    @IBOutlet weak var locationlbl: UILabel!

    private let viewModel = ViewControllerViewModel()
    private var restaurantList = [Nearby_restaurants]()
    var currenttSelectedItem : Restaurant?
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||  CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
                locationManager.requestAlwaysAuthorization()
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            print("Please turn on location services or GPS")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func registerCell(){
        restaurantTableView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: Constants.RESTAURANT_IDENTIFIER)
    }
    
    private func getRestaurants(){
        viewModel.getRestaurants { (restaurantCollection, error) in
            if error == nil{
                self.restaurantList = restaurantCollection!
                DispatchQueue.main.async {
                    self.restaurantTableView.reloadData()
                }
            }else{
                print("Myerror : \(String(describing: error))")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.FOOD_VC_SEGUE{
            let restaurantVC = segue.destination as! RestaurantViewController
            restaurantVC.restaurantObj = currenttSelectedItem
        }
    }
    
}


extension ViewController :  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.RESTAURANT_IDENTIFIER, for: indexPath) as? RestaurantCell
        ImageLib.sharedInstance().download(for: self.restaurantList[indexPath.row].restaurant?.featured_image ?? "", mountOver: (cell?.restaurantImg)!)
        cell?.ratinglbl.text = self.restaurantList[indexPath.row].restaurant?.user_rating?.aggregate_rating
        cell?.ratingView.backgroundColor = UIColor(hexString: (self.restaurantList[indexPath.row].restaurant?.user_rating?.rating_color)!)
        cell?.restaurantName.text = restaurantList[indexPath.row].restaurant?.name
        cell?.rating_txt.text = restaurantList[indexPath.row].restaurant?.user_rating?.rating_text
        cell?.locationlbl.text = restaurantList[indexPath.row].restaurant?.location?.address
        cell?.cuisine_txt.text = restaurantList[indexPath.row].restaurant?.cuisines
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currenttSelectedItem = restaurantList[indexPath.row].restaurant
        self.performSegue(withIdentifier: Constants.FOOD_VC_SEGUE, sender: self)
    }
}

extension ViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations.first
        if !viewModel.locationDict.isEmpty{ return }

        viewModel.prepareLocation(location: loc!)
        viewModel.makeCityReQuest { (islocationSaved, error) in
            print(" closure loc upadate")
            if islocationSaved{
                self.locationManager.stopUpdatingLocation()
                let data = UserDefaultManager.get(datafor: .CITY_DETAILS) as? [String:String]
                if let url = data?[UserDefaultConstant.LOC_IMAGE_URL]{
                    ImageLib.sharedInstance().download(for: url, mountOver: self.countryImg)
                }
                if let name = data?[UserDefaultConstant.LOC_NAME]{
                    DispatchQueue.main.async {
                        self.locationlbl.text = name
                    }
                }
                self.getRestaurants()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status -> \(status.rawValue)")
    }
}


