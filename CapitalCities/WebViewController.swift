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
		} else {
			showError(url: urlString)
		}
	}

	func showError(url: String) {
		let html = """
			<html>
			<head>
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<style>body { margin: 20px } div { font-size: 120% }</style>
			</head>
			<body>
			<h1>An error occurred!</h1>
			<div>"\(url)" is not a valid URL</div>
			</body>
			</html>
			"""
		webView.loadHTMLString(html, baseURL: nil)
	}
}
