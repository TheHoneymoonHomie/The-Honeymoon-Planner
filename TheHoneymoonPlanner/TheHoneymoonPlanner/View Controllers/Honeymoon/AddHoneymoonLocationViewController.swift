//
//  AddHoneymoonLocationViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jerry haaser on 2/5/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddHoneymoonLocationViewController: UIViewController {
    
    var pressedLocation:CLLocation? = nil {
        didSet{
            saveButton.isEnabled = true
            saveButton.isHighlighted = true
            print("pressedLocation was set")
        }
    }
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addLocationTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

                let location = CLLocationCoordinate2D(latitude: 33.812794,
                                                      longitude: -117.9190981)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                let region = MKCoordinateRegion(center: location, span: span)
                mapView.setRegion(region, animated: true)
                
                let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
                lpgr.minimumPressDuration = 0.5
                lpgr.delaysTouchesBegan = false
        //        lpgr.delegate = self
                self.mapView.addGestureRecognizer(lpgr)
    }
    
            @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
                if gestureReconizer.state != UIGestureRecognizer.State.ended {
                    //When lognpress is start or running
                }
                else {
                    print("I was long pressed...")
                    
                    let touchPoint = gestureReconizer.location(in: mapView)
                    let coordsFromTouchPoint = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                    pressedLocation = CLLocation(latitude: coordsFromTouchPoint.latitude, longitude: coordsFromTouchPoint.longitude)
    //                myWaypoints.append(location)
                    print("Location:", coordsFromTouchPoint.latitude, coordsFromTouchPoint.longitude)

                    let wayAnnotation = MKPointAnnotation()
                    wayAnnotation.coordinate = coordsFromTouchPoint
                    wayAnnotation.title = "waypoint"

                }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SaveBackToAddHoneymoonVCSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "SaveBackToAddHoneymoonVCSegue" {
            guard let destinationVC = segue.destination as? AddHoneymoonViewController,
                let pressedLocation = pressedLocation else { return }
            
            destinationVC.vacationLocation = pressedLocation
        }
    }

}
