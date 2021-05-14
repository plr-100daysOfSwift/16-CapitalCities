//
//  ViewController.swift
//  CapitalCities
//
//  Created by Paul Richardson on 14/05/2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

	@IBOutlet var mapView: MKMapView!

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(changeMapType))

		let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
		let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
		let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8667, longitude: 2.3508), info: "Often called the City of Light.")
		let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.56), info: "Has a whole country inside it.")
		let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

		mapView.addAnnotations([london, oslo, paris, rome, washington])
	}

	@objc func changeMapType() {
		let ac = UIAlertController(title: "Choose a map type", message: nil, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { _ in
			self.mapView.mapType = .standard
		}))
		ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { _ in
			self.mapView.mapType = .satellite
		}))
		ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { _ in
			self.mapView.mapType = .hybrid
		}))
		present(ac, animated: true)
	}

	// MARK:- MapView Delegate Methods

	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard annotation is Capital else { return nil }
		let identifier = "Capital"
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

		if annotationView == nil {
			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			annotationView?.canShowCallout = true
			annotationView?.pinTintColor = .green
			let btn = UIButton(type: .detailDisclosure)
			annotationView?.rightCalloutAccessoryView = btn
		} else {
			annotationView?.annotation = annotation
		}

		return annotationView
	}

	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		guard let capital = view.annotation as? Capital else { return }
		let placeName = capital.title
		let vc = WebViewController()
		vc.city = placeName
		navigationController?.pushViewController(vc, animated: true)
		view.setSelected(false, animated: false)
	}
	
}

