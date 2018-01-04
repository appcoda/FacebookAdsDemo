//
//  FullScreenAdsViewController.swift
//  AdsTutorial
//
//  Created by Gabriel Theodoropoulos on 29/07/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class FullScreenAdsViewController: UIViewController, FBInterstitialAdDelegate {

    @IBOutlet weak var btnShowAd: UIButton!
    
    
    var fullScreenAd: FBInterstitialAd!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showFullScreenAd(sender: AnyObject) {
        fullScreenAd = FBInterstitialAd(placementID: "PLACEMENT_ID")
        fullScreenAd.delegate = self
        fullScreenAd.load()
        btnShowAd.isEnabled = false
    }

    
    // MARK: FBInterstitialAdDelegate Methods
    
    func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
        interstitialAd.show(fromRootViewController: self)
        btnShowAd.isEnabled = true
    }
    
    func interstitialAd(_ interstitialAd: FBInterstitialAd, didFailWithError error: Error) {
        print(error)
        btnShowAd.isEnabled = true
    }
    
    func interstitialAdDidClick(_ interstitialAd: FBInterstitialAd) {
        print("Did tap on ad")
    }
    
    
    func interstitialAdDidClose(_ interstitialAd: FBInterstitialAd) {
        print("Did close ad")
    }
}
