//
//  DetailViewController.swift
//  Whitehouse-Petitions
//
//  Created by Logesh Palani on 20/08/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webview: WKWebView!
    var petition: Petition?
    
    override func loadView() {
        webview = WKWebView()
        view = webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let html = """
        <html>
        <head>
        <mata name="viewport" content="width=device-width, initial-scale=1">
        <style>body { font-size:250%; }</style>
        </head>
        <body>
        \(petition!.body)
        </body>
        </html>
        """
        webview.loadHTMLString(html, baseURL: nil)
        // Do any additional setup after loading the view.
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
