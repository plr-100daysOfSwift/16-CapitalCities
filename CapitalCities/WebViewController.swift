//
//  WebViewController.swift
//  CapitalCities
//
//  Created by Paul Richardson on 15/05/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

	var webView: WKWebView!
	var city: String?

	override func loadView() {
		webView = WKWebView()
		view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		guard let city = city else { return }
		let urlString = "http://en.wikipedia.org/?search=\(city)"
		if let myURL = URL(string: urlString) {
			let myRequest = URLRequest(url: myURL) 
			webView.load(myRequest)
		}
	}

}
