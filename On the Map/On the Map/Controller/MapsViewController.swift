//
//  MapViewController.swift
//  On the Map
//
//  Created by Reem on 5/10/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var studentArray = [StudentLocation]()
    var pntAnnotation = [MKPointAnnotation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        handleGetStudentLocations()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
        handleGetStudentLocations()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            if let toOpen = view.annotation?.subtitle! {
                UIApplication.shared.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    func handleGetStudentLocations()
    {
        ParseClient.getStudentsLocations { (response
            , error) in
            if response.count > 0 {
                self.studentArray = response
        StudentModel.students = response
              self.handleCreateAnnotations()
            }
            else
            {
                self.showAlert(message: "Failed to download locations.")
            }
    }
        
      
    }
    
    func handleCreateAnnotations()
    {
       
        
        for location in StudentModel.students {

            let latitude = CLLocationDegrees(location.latitude ?? 0)
            let longitude = CLLocationDegrees(location.longitude ?? 0)

            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let first = location.firstName
            let last = location.lastName
            let mediaURL = location.mediaURL
            
            let newAnnotation = MKPointAnnotation()
            newAnnotation.coordinate = coordinate
            newAnnotation.title = "\(first ?? "") \(last ?? "")"
            newAnnotation.subtitle = mediaURL
            
          
            pntAnnotation.append(newAnnotation)
        }
        
     
        self.mapView.addAnnotations(pntAnnotation)
        
    }
    
    
}
