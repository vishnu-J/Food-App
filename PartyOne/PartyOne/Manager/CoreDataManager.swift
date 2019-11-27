//
//  CoreDataManager.swift
//  GreedyGamePanel
//
//  Created by vishnu j on 19/09/18.
//  Copyright © 2018 GreedyGame. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var context:NSManagedObjectContext?
    var entityDescription : NSEntityDescription?

    
    override init() {
        super.init()
        if #available(iOS 10.0, *) {
            context = appdelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
        }
    }
    
    /*func saveData(data:Any, for entity:Entities) {
        guard let mycontext = context else { return }
        switch entity {
        case .LOCATION_DETAILS:
            entityDescription = NSEntityDescription.entity(forEntityName: entity.rawValue, in: mycontext)
        default:
            
        }
        guard let entity = entityDescription else { return }

        guard let results = data.results else { return }
        
        var actualData = [Results]()
        
        let fetchedData = self.fetchData()
        
        if let datapresent = fetchedData {
            
            for data in datapresent{
                data.setValue(String(0), forKey: "expireat")
            }
            
            var locallist = [String]()
            var apilist = [String]()
          
            if datapresent.count > 0{
                for localdata in datapresent {
                    guard let gameid = localdata.gameid else {return}
                    locallist.append(gameid)
                }
                
                for apidata in results{
                    apilist.append(apidata.game_id!)
                }
                
                let localdataset = Set(locallist)
                let apidataset = Set(apilist)
                let finalResult = Array(apidataset.subtracting(localdataset))
                for id in finalResult{
                    let filterData = results.filter({ ($0.game_id?.contains(id))!})
                    actualData = filterData
                }
            }else{
                actualData = results
            }
        }

        for details in actualData {
            let deviceDetails = NSManagedObject(entity: entity, insertInto: mycontext)

            if let id = details.id {
                deviceDetails.setValue(String(id), forKey: "id")
            }
            if let adgroup = details.ad_group {
                deviceDetails.setValue(String(adgroup), forKey: "adgroup")
            }
            if let gameId = details.game_id {
                deviceDetails.setValue(String(gameId), forKey: "gameid")
            }
            if let exchange = details.exchange {
                deviceDetails.setValue(String(exchange), forKey: "exchange")
            }
            if let expireat = details.expire_at {
                deviceDetails.setValue(String(expireat), forKey: "expireat")
            }
        }
        
        do {
            if actualData.count > 0{
                try mycontext.save()
                updatetheExistingData(resultsdata: results)
                print("The Data saved successfully")
            }else{
                print("There is no new Data found")
                updatetheExistingData(resultsdata: results)
            }
        } catch {
            print("Failed")
        }
    }
    
    func RefreshDeviceUpdate(model:StagedDeviceModel) {
        guard let mycontext = context else { return}
        let fetchedData = self.fetchData()
        var modellist = [String]()
        var locallist = [String]()
        
        for data in model.results!{
            modellist.append(data.game_id!)
        }
        
        for data in fetchedData! {
            locallist.append(data.gameid!)
        }
        
        let localdataset = Set(locallist)
        let modeldataset = Set(modellist)
        let finalResult = Array(localdataset.subtracting(modeldataset))
        for id in finalResult{
            let filterData = fetchedData?.filter({ ($0.gameid?.contains(id))!})
            for data in filterData!{
                data.setValue(String(0), forKey: "expireat")
            }
        }
        
        do {
           try  mycontext.save()
        }catch{
            print("Device refresh has error when updating the value")
        }
        
        self.updatetheExistingData(resultsdata: model.results!)
    }
        
    func fetchData() -> [StagedDevices]? {
        guard let mycontext = context else { return nil}
        var result:[StagedDevices]?
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StagedDevices")
        
        do {
            result = try mycontext.fetch(request) as? [StagedDevices]
        } catch {
            print("Failed to retrive data")
            result = nil
        }
        return result
    }
    
    func updatetheExistingData(resultsdata:[Results]) {
        guard let mycontext = context else { return}
         let fetchedData = self.fetchData()
        for data in resultsdata {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StagedDevices")
            guard let gameid = data.game_id else {
                print("Game id is nil,when update the current model")
                return
            }
            
            request.predicate = NSPredicate(format: "gameid = %@",gameid )
            request.returnsObjectsAsFaults = false

            
            do {
                let result = try mycontext.fetch(request)
                let firstObj = result.first as? StagedDevices
                for data in fetchedData!{
                    if (firstObj?.gameid!) == data.gameid{
                        print("local data expire time -> \(data.expireat!)")
                    }
                }
                print("firstobj -> \(String(describing: firstObj?.expireat))")
                firstObj?.setValue(String(data.expire_at!) , forKey: "expireat")
                do {
                    try mycontext.save()
                    print("The Data saved successfully")
                } catch {
                    print("updation Failed")
                }
            }catch{
                print("Failed to fetch the when update the unstage timestamp")
            }
        }
    }
    
    func updateData(model:Results) {
        guard let mycontext = context else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StagedDevices")
        guard let gameid = model.game_id else {
            print("Game id is nil,when update the current model")
            return
        }
        request.predicate = NSPredicate(format: "gameid = %@", gameid)
        request.returnsObjectsAsFaults = false

        do {
            let result = try mycontext.fetch(request)
                if result.count > 0{
                    let firstObj = result.first as? StagedDevices
                    
                    if let id = model.id {
                        firstObj?.setValue(String(id), forKey: "id")
                    }
                    if let adgroup = model.ad_group {
                        firstObj?.setValue(String(adgroup), forKey: "adgroup")
                    }
                    if let gameId = model.game_id {
                        firstObj?.setValue(String(gameId), forKey: "gameid")
                    }
                    if let exchange = model.exchange {
                        firstObj?.setValue(String(exchange), forKey: "exchange")
                    }
                    if let expireat = model.expire_at {
                        firstObj?.setValue(String(expireat), forKey: "expireat")
                    }
                    do {
                        try mycontext.save()
                        print("The Data upated successfully")
                    } catch {
                        print("updation Failed")
                    }
                }else{
                     let entityDescription = NSEntityDescription.entity(forEntityName: "StagedDevices", in: mycontext)
                     guard let entity = entityDescription else { return }
                     let deviceDetails = NSManagedObject(entity: entity, insertInto: mycontext)
                     if let id = model.id {
                     deviceDetails.setValue(String(id), forKey: "id")
                     }
                     if let adgroup = model.ad_group {
                     deviceDetails.setValue(String(adgroup), forKey: "adgroup")
                     }
                     if let gameId = model.game_id {
                     deviceDetails.setValue(String(gameId), forKey: "gameid")
                     }
                     if let exchange = model.exchange {
                     deviceDetails.setValue(String(exchange), forKey: "exchange")
                     }
                     if let expireat = model.expire_at {
                     deviceDetails.setValue(String(expireat), forKey: "expireat")
                     }
                     do {
                     try mycontext.save()
                     print("saved Data as new data")
                     } catch {
                     print("failed to save the new data")
                     }
                }
        } catch {
            print("Failed to retrive data")
        }
    }
    
    func unStageUpdate(model:StagedDevices) -> Bool{
        guard let mycontext = context else { return false}
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StagedDevices")
        request.predicate = NSPredicate(format: "gameid = %@", model.gameid!)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try mycontext.fetch(request)
            let firstObj = result.first as? StagedDevices
            firstObj?.setValue(String(0), forKey: "expireat")
            
            do {
                try mycontext.save()
                print("The Data saved successfully")
                return true
            } catch {
                print("updation Failed")
                return false
            }
        }catch{
            print("Failed to fetch the when update the unstage timestamp")
        }
        return false
    }
    
    func saveGameData(model:[GameDetailModel]) -> Bool{
        guard let mycontext = context else { return false }
        let entityDescription = NSEntityDescription.entity(forEntityName: "GameDetails", in: mycontext)
        guard let entity = entityDescription else { return false }
        let gamedetail = NSManagedObject(entity: entity, insertInto: mycontext)
        for detail in model{
            if let id = detail.id, let name = detail.title {
                gamedetail.setValue(id, forKey: "id")
                gamedetail.setValue(name, forKey: "name")
            }
        }
        
        do {
            try mycontext.save()
            print("The  game data saved successfully")
            return true
        } catch {
            print("Failed")
            return false
        }
    }
    
    func fetchGameData() -> [GameDetails]? {
        guard let mycontext = context else { return nil }
        var result:[GameDetails]?
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameDetails")
        do {
            result = try mycontext.fetch(request) as? [GameDetails]
        } catch {
            print("Failed to retrive game data")
            result = nil
        }
        return result
    }*/
    
    
}
