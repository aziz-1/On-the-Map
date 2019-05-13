//
//  PostStudentViewController.swift
//  On the Map
//
//  Created by Reem on 5/11/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation


class PostStudentViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var coordinates: CLLocationCoordinate2D!
    var annotation = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       setFields(found: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       setFields(found: false)
    }
    
    
    @IBAction func findLocation(_ sender: Any) {
        activityIndicator.startAnimating()
        if let location = locationTextField.text {
            getLatLong(location: location) { (coordinates, error) in
                if let coordinates = coordinates {
                    DispatchQueue.main.async {
                        self.coordinates = coordinates
                       
                        self.annotation.coordinate = coordinates
                        self.annotation.title = "New annotation"
                        self.mapView.addAnnotation(self.annotation)
                        
                        self.mapView.setRegion(MKCoordinateRegion(center: self.coordinates, span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(exactly: 0.002)!, longitudeDelta: CLLocationDegrees(exactly: 0.002)!)), animated: true)
                       
                        self.setFields(found: true)
                      self.activityIndicator.stopAnimating()
                    }
                    
                }
                else
                {
                    self.showAlert(message: "Incorrect Location")
                    self.activityIndicator.stopAnimating()
                }
            }}
            else {
                showAlert(message: "Location cannot be empty")
            self.activityIndicator.stopAnimating()
            }
            
        }
    
    func getLatLong(location: String, completion: @escaping(_ coor: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(location) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        if let link = self.linkTextField.text {
        let location = StudentRequest(uniqueKey: "", firstName: "DummyFirstName", lastName: "DummayLastName", mapString: locationTextField.text!, mediaURL: link, latitude: coordinates.latitude.binade, longitude: coordinates.longitude.binade)
            
            ParseClient.addStudnet(student: location) { (response, error) in
                if  error != nil {
                    self.showAlert(message: response?.error ?? "")
                    
                }
                else{
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        else {
            self.showAlert(message: "Link cannot be empty")
        }
    }
    
  
    @IBAction func cancelView(_ sender: Any) {
 self.dismiss(animated: true, completion: nil)    }
    
    func setFields(found: Bool)
    {
        if !found {
            self.submitButton.isHidden = !found
            self.linkTextField.tintColor = .gray
            self.linkTextField.isEnabled = found
        }
        else
        {
            self.submitButton.isHidden = !found
            self.findButton.isHidden = found
            self.locationTextField.isEnabled = !found
            self.locationTextField.tintColor = .gray
            self.linkTextField.isEnabled = found
            self.linkTextField.tintColor = .none
        }
    }
    
}


