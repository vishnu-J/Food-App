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
    
    static let TAG = "VC"
    
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var restaurantTableView: UITableView!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var menutableView: UITableView!
    @IBOutlet weak var menuTopView: UIView!
    @IBOutlet weak var sideMenu: UIView!
    
    private let viewModel = ViewControllerViewModel()
    private var restaurantList = [Nearby_restaurants]()
    var selectedItem : Restaurant?
    let locationManager = CLLocationManager()
    var isMenuOpened = false
    let menuList = ["Restaurant \n Collections","Cusines"]
    let menuImage = ["category", "cuisine"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        menutableView.delegate = self
        menutableView.dataSource = self
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
            Alert.alert(message: "Please turn on location services or GPS", actionTitle: "Ok", vc:self)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func clsoeBtnAction(_ sender: UIButton) {
       closeSideMenu()
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        openSideMenu()
    }
    
    // MARK : Helper Methods
    private func openSideMenu(){
        if !isMenuOpened{
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                switch UIDevice.current.userInterfaceIdiom{
                case .phone:
                    self.sideMenu.transform = CGAffineTransform(translationX: 200, y: 0)
                case .pad:
                    self.sideMenu.transform = CGAffineTransform(translationX: 400, y: 0)
                default: break
                }
            }, completion: nil)
            isMenuOpened = true
        }
    }
    
    private func closeSideMenu(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.sideMenu.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
        isMenuOpened = false
    }
    
    private func registerCell(){
        restaurantTableView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: Constants.RESTAURANT_IDENTIFIER)
        menutableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: Constants.MENU_IDENTIFIER)
    }
    
    private func getRestaurants(){
        viewModel.getRestaurants { (restaurantCollection, error) in
            if error == nil{
                self.restaurantList = restaurantCollection!
                DispatchQueue.main.async {
                    self.restaurantTableView.reloadData()
                }
            }else{
                Logger.i(ViewController.TAG, "ERROR : \(String(describing: error))")
            }
        }
    }
    
    private func openRestaurantCollectionVC(){
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAME, bundle: nil)
        let res_coll_vc = storyBoard.instantiateViewController(withIdentifier: Constants.RESTAURANT_COLLECTION_VC_ID) as! RestaurantCollectionVc
        self.navigationController?.pushViewController(res_coll_vc, animated: true)
    }
    
    
    private func openCuisineVC(){
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_NAME, bundle: nil)
        let res_coll_vc = storyBoard.instantiateViewController(withIdentifier: Constants.CUISINE_VC_ID) as! CuisineVC
        self.navigationController?.pushViewController(res_coll_vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.FOOD_VC_SEGUE{
            let restaurantVC = segue.destination as! RestaurantViewController
            restaurantVC.restaurantObj = selectedItem
        }
    }
    
}


extension ViewController :  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menutableView{
            return menuList.count
        }else{
            return restaurantList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == menutableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MENU_IDENTIFIER, for: indexPath) as! MenuCell
            cell.menuNamelbl.text = menuList[indexPath.row]
            cell.menuImageView.image = UIImage(named: menuImage[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.RESTAURANT_IDENTIFIER, for: indexPath) as? RestaurantCell
            ImageLib.sharedInstance().download(for: self.restaurantList[indexPath.row].restaurant?.featured_image ?? "", mountOver: (cell?.restaurantImg)!)
            cell?.ratinglbl.text = "\(self.restaurantList[indexPath.row].restaurant?.user_rating?.aggregate_rating ?? "0")*"
            cell?.ratingView.backgroundColor = UIColor(hexString: (self.restaurantList[indexPath.row].restaurant?.user_rating?.rating_color)!)
            cell?.restaurantName.text = restaurantList[indexPath.row].restaurant?.name
            cell?.rating_txt.text = restaurantList[indexPath.row].restaurant?.user_rating?.rating_text
            cell?.locationlbl.text = restaurantList[indexPath.row].restaurant?.location?.address
            cell?.cuisine_txt.text = restaurantList[indexPath.row].restaurant?.cuisines
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       let device = UIDevice.current.userInterfaceIdiom
        switch device {
        case .phone:
            if tableView == menutableView{
                return 50
            }
            return (tableView.frame.height/2) - 10
        case .pad:
            if tableView == menutableView{
                return 100
            }
            return 400
        default:break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == menutableView{
            if indexPath.row == 0{
                self.openRestaurantCollectionVC()
            }else if indexPath.row == 1{
                self.openCuisineVC()
            }
            closeSideMenu()
        }else{
            selectedItem = restaurantList[indexPath.row].restaurant
            self.performSegue(withIdentifier: Constants.FOOD_VC_SEGUE, sender: self)
        }
    }
}

extension ViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations.first
        if !viewModel.locationDict.isEmpty{ return }

        viewModel.prepareLocation(location: loc!)
        viewModel.makeCityReQuest { (islocationSaved, error) in
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
            }else{
                Logger.i(ViewController.TAG,"location not saved because of \(String(describing: error))")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        Logger.i(ViewController.TAG,"Authorization Status Changed : \(status.rawValue)")
        if status.rawValue == 4{
            locationManager.startUpdatingLocation()
        }
//        if status.rawValue != 4 || status.rawValue != 3{
//            Alert.alert(message: "Please turn on location services or GPS", actionTitle: "Ok", vc:self)
//        }
    }
}


