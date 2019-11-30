//
//  CuisineVC.swift
//  PartyOne
//
//  Created by Vishnu on 30/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class CuisineVC: UIViewController {
   
    @IBOutlet weak var cuisine_tableView: UITableView!
    
    private let cuisineViewModel = CuisineViewModel()
    private var cuisineList = [Cuisines]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cuisine_tableView.delegate = self
        cuisine_tableView.dataSource = self
        getCuisines()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK : Helper Methods
    private func getCuisines(){
        self.cuisineViewModel.getCuisines { (cuisineList, error) in
            if error == nil{
                self.cuisineList = (cuisineList?.cuisines)!
                DispatchQueue.main.async {
                    self.cuisine_tableView.reloadData()
                }
            }else{
                print("Error: Cuisine request Failed with \(error!)")
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

extension CuisineVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cuisineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CUISINE_IDENTIFIER, for: indexPath)
        cell.textLabel?.text = self.cuisineList[indexPath.row].cuisine?.cuisine_name ?? "None"
        cell.textLabel?.textColor = .orange
        
        switch UIDevice.current.userInterfaceIdiom {

        case .pad:
            cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        default:break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 50
        case .pad:
            return 100
        default:break
        }
        
        return 0
    }
}
