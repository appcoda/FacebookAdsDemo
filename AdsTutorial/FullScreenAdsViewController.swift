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
        fullScreenAd.loadAd()
        btnShowAd.enabled = false
    }

    
    // MARK: FBInterstitialAdDelegate Methods
    
    func interstitialAdDidLoad(interstitialAd: FBInterstitialAd) {
        interstitialAd.showAdFromRootViewController(self)
        btnShowAd.enabled = true
    }
    
    
    func interstitialAd(interstitialAd: FBInterstitialAd, didFailWithError error: NSError) {
        print(error)
        btnShowAd.enabled = true
    }
    
    
    func interstitialAdDidClick(interstitialAd: FBInterstitialAd) {
        print("Did tap on ad")
    }
    
    
    func interstitialAdDidClose(interstitialAd: FBInterstitialAd) {
        print("Did close ad")
    }
}
