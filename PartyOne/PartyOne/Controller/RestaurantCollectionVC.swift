//
//  RestaurantCollectionVC.swift
//  PartyOne
//
//  Created by Vishnu on 29/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class RestaurantCollectionVc: UIViewController {
    
    @IBOutlet weak var res_collection_tableView: UITableView!
    
    private let res_collection_viewModel = RestaurantCollectionViewModel()
    private var collection = [Collections]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        res_collection_tableView.delegate = self
        res_collection_tableView.dataSource = self
        registerCell()
        getRestaurants()
    }
    
    private func registerCell(){
        res_collection_tableView.register(UINib(nibName: "RestaurantCollectionCell", bundle: nil), forCellReuseIdentifier: Constants.RESTAURANT_COLLECTION_IDENTIFIER)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func getRestaurants(){
        res_collection_viewModel.getRestaurantCollections { (resCollection, error) in
            if error == nil{
                guard let collections = resCollection?.collections else{
                    print("ERROR: Restaurant collections are empty")
                    return
                }
                self.collection = collections
                DispatchQueue.main.async {
                    self.res_collection_tableView.reloadData()
                }
            }else{
                print("Error : when requesting restaurant collection beacause of \(String(describing: error))")
            }
        }
        
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

extension RestaurantCollectionVc : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.RESTAURANT_COLLECTION_IDENTIFIER, for: indexPath) as? RestaurantCollectionCell
        ImageLib.sharedInstance().download(for: self.collection[indexPath.row].collection?.image_url ?? "", mountOver: (cell?.res_imgView)!)
        cell?.res_namelbl.text = self.collection[indexPath.row].collection?.title ?? "-"
        cell?.res_descriptionlbl.text = self.collection[indexPath.row].collection?.description ?? "-"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 150
        case .pad:
            return 300
        default:break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let shareURL = self.collection[indexPath.row].collection?.share_url else{
            print("Error: Share URL Unavailable")
            return
        }
        External.openSafari(withURL: shareURL)
    }
    
}
