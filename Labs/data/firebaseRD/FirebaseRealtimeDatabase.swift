//
//  FirebaseRealtimeDatabase.swift
//  Labs
//
//  Created by Junio Moquiuti on 31/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift
import Result
import FirebaseDatabase

protocol FirebaseRealtimeDatabaseProtocol {
    var labsResponseVariable: Variable<RequestResponse<[LabAPI]?>> {get}
    func getAllLabsInDB()
}

class FirebaseRealtimeDatabase: FirebaseRealtimeDatabaseProtocol {
    
    var ref: DatabaseReference! {
        didSet {bind()}
    }
    
    var labsResponseVariable = Variable<RequestResponse<[LabAPI]?>>(.new)
    
    private func bind() {
        
        ref.queryOrdered(byChild: "projects").observe(.childChanged, with: { [weak self] (snapshot) in
            
            guard let strongSelf = self else {return}
            guard let values = snapshot.value as? [Any] else {return}
            var labsAPI = [LabAPI]()
            
            for value in values {
                guard let valueJson = value as? [String: Any] else {return}
                guard let labAPI = LabAPI(JSON: valueJson) else {return}
                
                labsAPI.append(labAPI)
            }
            
            strongSelf.labsResponseVariable.value = .success(responseObject: labsAPI)
        
        }) { (error) in
            print("Error get childChanged -> \(error.localizedDescription)")
        }
        
        ref.queryOrdered(byChild: "projects").observe(.childRemoved, with: { [weak self] (snapshot) in
      
            guard let strongSelf = self else {return}
            guard let values = snapshot.value as? [Any] else {return}
            var labsAPI = [LabAPI]()
            
            for value in values {
                guard let valueJson = value as? [String: Any] else {return}
                guard let labAPI = LabAPI(JSON: valueJson) else {return}
                
                labsAPI.append(labAPI)
            }
            
            strongSelf.labsResponseVariable.value = .success(responseObject: labsAPI)
        }) { (error) in
            print("Error get childChanged -> \(error.localizedDescription)")
        }
    }
    
    func getAllLabsInDB() {
        ref = Database.database().reference()
        
        labsResponseVariable.value = .loading
        
        ref.queryOrdered(byChild: "projects").observe(.childAdded, with: { [weak self] (snapshot) in
            guard let strongSelf = self else {return}
            guard let values = snapshot.value as? [Any] else {return}
            var labsAPI = [LabAPI]()
            
            for value in values {
                guard let valueJson = value as? [String: Any] else {return}
                guard let labAPI = LabAPI(JSON: valueJson) else {return}
                
                labsAPI.append(labAPI)
            }
            
            strongSelf.labsResponseVariable.value = .success(responseObject: labsAPI)
        }) { [weak self] (error) in
            guard let strongSelf = self else {return}
            strongSelf.labsResponseVariable.value = .failure(error: error.localizedDescription)
        }
    }
}
