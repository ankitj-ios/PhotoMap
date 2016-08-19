//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
                                              MKCoordinateSpanMake(0.1, 0.1))
        mapView.setRegion(sfRegion, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCameraButton(sender: AnyObject) {
        print("on camera button press ... ")
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        } else if (UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)) {
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else if (UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum)) {
            vc.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        }
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        _ = info[UIImagePickerControllerOriginalImage] as! UIImage
        _ = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("tagSegue", sender: nil)
    }

    func locationsPickedLocation(controller: LocationsViewController, name : String, latitude: NSNumber, longitude: NSNumber) {
        self.navigationController?.popViewControllerAnimated(true)
        let latString = "\(latitude)"
        let lngString = "\(longitude)"
        print(name + " " + latString + " " + lngString)
        
        let annotation = MKPointAnnotation()
        let myLocation = CLLocation(latitude: CLLocationDegrees(Double(latitude)), longitude: CLLocationDegrees(Double(longitude)))
        annotation.coordinate = myLocation.coordinate
        annotation.title = name
        mapView.addAnnotation(annotation)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destinationViewController as! LocationsViewController
        destinationViewController.delegate = self
    }

}
