//
//  AddActivityMapViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jerry haaser on 2/3/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import MapKit

class AddActivityMapViewController: UIViewController {
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    var activty: Activity?
    var activities: [Activity] = []
    
    var pressedLocation:CLLocation? = nil {
        didSet{
            continueButton.isEnabled = true
            continueButton.isHighlighted = true
            print("pressedLocation was set")
        }
    }
    var activityLocationTitle: String?
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
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
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
            guard let pressedLocation = pressedLocation else { return }
            //let actionLocationTitle = addLocationTextField.text
        CoreDataStack.saveContext()
        print(pressedLocation)
        //print(vacationLocationTitle)
        
        //TODO: This should not popViewController but continue on to next view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
