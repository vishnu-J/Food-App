//
//  ViewController.swift
//  PartyOne
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    static let TAG = "VC"
    
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var restaurantTableView: UITableView!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var menutableView: UITableView!
    @IBOutlet weak var menuTopView: UIView!
    @IBOutlet weak var sideMenu: UIView!
    
    @IBOutlet weak var mapKitHolder: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var transportType: UIButton!

    @IBOutlet weak var mapClosebtn: UIButton!
    
    private let viewModel = ViewControllerViewModel()
    private var restaurantList = [Nearby_restaurants]()
    var selectedItem : Restaurant?
    let locationManager = CLLocationManager()
    var currentLocCoordinate : CLLocationCoordinate2D?
    var isMenuOpened = false
    var isMapMenuExpanded = false
    var blurView : UIView?
    let menuList = ["Restaurant \n Collections","Cusines"]
    let menuImage = ["category", "cuisine"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        menutableView.delegate = self
        menutableView.dataSource = self
        mapView.delegate = self
        registerCell()
        
        blurView = UIView(frame: view.frame)
        blurView?.backgroundColor = .black
        blurView?.alpha = 0.5
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

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mapKitHolder.roundCorners(corners: [.topRight, .topLeft], radius: 10)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func clsoeBtnAction(_ sender: UIButton) {
       closeSideMenu()
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        openSideMenu()
    }
    
    @IBAction func mapCloseBtnAction(_ sender: UIButton) {
        
        removeBlurView()

        UIView.animate(withDuration: 1) {
            self.mapKitHolder.transform = CGAffineTransform(translationX: 0, y: 0)
        }
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
    
    private func addBlurView(){
        view.addSubview(blurView!)
        view.bringSubviewToFront(blurView!)
    }
    
    private func removeBlurView(){
        view.sendSubviewToBack(blurView!)
        blurView!.removeFromSuperview()
        print(view)
    }
    
    @objc private func openMap(sender:UIButton){
        print("sender : \(sender.tag)")
        
        let lat = self.restaurantList[sender.tag].restaurant?.location?.latitude
        let long = self.restaurantList[sender.tag].restaurant?.location?.longitude

      
//        view.bringSubviewToFront(blurView)
        addBlurView()
        
        view.bringSubviewToFront(mapKitHolder)

        
        UIView.animate(withDuration: 1) {
            self.mapKitHolder.transform = CGAffineTransform(translationX: 0, y: -300)
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (currentLocCoordinate?.latitude)!, longitude: (currentLocCoordinate?.longitude)!), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(lat!)!, longitude: Double(long!)!), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    @IBAction func plusBtnAction(_ sender: UIButton) {

        UIView.animate(withDuration: 0.5) {
            if !self.isMapMenuExpanded{
                sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
                self.transportType.transform = CGAffineTransform(translationX: 0, y: -50)
                self.isMapMenuExpanded = true
            }else{
                sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -2)
                self.transportType.transform = CGAffineTransform(translationX: 0, y: 0)
                self.isMapMenuExpanded = false
            }
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
            cell?.locationbtn.tag = indexPath.row
            cell?.locationbtn.addTarget(self, action: #selector(openMap(sender:)), for: .touchUpInside)
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

        self.currentLocCoordinate = loc?.coordinate
        viewModel.prepareLocation(location: loc!)
        viewModel.makeCityReQuest { (islocationSaved, error) in
            if islocationSaved{
                self.locationManager.stopUpdatingLocation()
                let data = UserDefaultManager.get(datafor: .CITY_DETAILS) as? [String:String]
                /*if let url = data?[UserDefaultConstant.LOC_IMAGE_URL]{
                    ImageLib.sharedInstance().download(for: url, mountOver: self.countryImg)
                }*/
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

extension ViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        print(" Map render")
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 2
        return renderer
    }
    
    
}


