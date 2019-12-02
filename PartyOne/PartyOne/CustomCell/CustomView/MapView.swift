//
//  MapView.swift
//  PartyOne
//
//  Created by Vishnu on 02/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mainContentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }
   
    
    private func configureViews()
    {
        let nibidentifier = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MapView", bundle: nibidentifier)
        mainContentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(mainContentView!)
        
//        mainContentView?.center = self.center
//        mainContentView?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
//        mainContentView?.translatesAutoresizingMaskIntoConstraints = true
    }

}
