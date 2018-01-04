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
        bannerAdView.frame = CGRect(x:0.0, y:20.0, width:UIScreen.main.bounds.size.width, height:50.0)
        bannerAdView.delegate = self
        bannerAdView.isHidden = true
        self.view.addSubview(bannerAdView)
        
        bannerAdView.loadAd()
    }

    
    
    // MARK: FBAdViewDelegate Methods
    
    func adViewDidLoad(_ adView: FBAdView) {
        bannerAdView.isHidden = false
    }
    
    
    func adView(_ adView: FBAdView, didFailWithError error: Error) {
        print(error)
    }
    
    func adViewDidClick(_ adView: FBAdView) {
        print("Did tap on ad view")
    }
}
