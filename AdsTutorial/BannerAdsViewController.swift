//
//  BannerAdsViewController.swift
//  AdsTutorial
//
//  Created by Gabriel Theodoropoulos on 29/07/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class BannerAdsViewController: UIViewController, FBAdViewDelegate {
    
    var bannerAdView: FBAdView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loadBannerAd(sender: AnyObject) {
        bannerAdView = FBAdView(placementID: "PLACEMENT_ID", adSize: kFBAdSizeHeight50Banner, rootViewController: self)
        bannerAdView.frame = CGRectMake(0.0, 20.0, UIScreen.mainScreen().bounds.size.width, 50.0)
        bannerAdView.delegate = self
        bannerAdView.hidden = true
        self.view.addSubview(bannerAdView)
        
        bannerAdView.loadAd()
    }

    
    
    // MARK: FBAdViewDelegate Methods
    
    func adViewDidLoad(adView: FBAdView) {
        bannerAdView.hidden = false
    }
    
    
    func adView(adView: FBAdView, didFailWithError error: NSError) {
        print(error)
    }
    
    func adViewDidClick(adView: FBAdView) {
        print("Did tap on ad view")
    }
}
