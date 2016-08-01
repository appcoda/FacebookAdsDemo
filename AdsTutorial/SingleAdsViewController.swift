//
//  SingleAdsViewController.swift
//  AdsTutorial
//
//  Created by Gabriel Theodoropoulos on 29/07/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class SingleAdsViewController: UIViewController, FBNativeAdDelegate {

    @IBOutlet weak var viewAdContainer: UIView!
    
    @IBOutlet weak var lblAdTitle: UILabel!
    
    @IBOutlet weak var lblAdBody: UILabel!
    
    @IBOutlet weak var imgAdIcon: UIImageView!
    
    @IBOutlet weak var btnAdAction: UIButton!
    
    @IBOutlet weak var lblSocialContext: UILabel!
    
    
    var nativeAd: FBNativeAd!
    
    var coverMediaView: FBMediaView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewAdContainer.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func loadNativeAd(sender: AnyObject) {
        if coverMediaView != nil {
            coverMediaView.removeFromSuperview()
            coverMediaView = nil
        }
        
        if nativeAd != nil {
            nativeAd.unregisterView()
        }
        
        nativeAd = FBNativeAd(placementID: "PLACEMENT_ID")
        nativeAd.delegate = self
        nativeAd.loadAd()
    }
 
    
    // MARK: Custom Methods

    func handleLoadedNativeAdUsingCustomViews() {
        // Set the ad title.
        lblAdTitle.text = nativeAd.title
        
        // Set the ad body (if exists).
        if let body = nativeAd.body {
            lblAdBody.text = body
        }
        
        // Set the title of the call-to-action button.
        btnAdAction.setTitle(nativeAd.callToAction, forState: UIControlState.Normal)
        
        // Load and display the ad icon image.
        nativeAd.icon?.loadImageAsyncWithBlock({ (iconImage) in
            if let image = iconImage {
                self.imgAdIcon.image = image
            }
        })
        
        // Create a cover media view and assign the native ad object to it (it will display image(s) or video, depending on what ad contains).
        let yPoint = lblAdBody.frame.origin.y + lblAdBody.frame.size.height + 8.0
        let coverMediaViewFrame = CGRectMake(lblAdBody.frame.origin.x, yPoint, lblAdBody.frame.size.width, lblSocialContext.frame.origin.y - yPoint - 8.0)
        let coverMediaView = FBMediaView(frame: coverMediaViewFrame)
        coverMediaView.clipsToBounds = true
        coverMediaView.nativeAd = nativeAd
        viewAdContainer.addSubview(coverMediaView)
        
        
        // Set the social context title (if exists).
        if let socialContext = nativeAd.socialContext {
            lblSocialContext.text = socialContext
        }
        
        
        // Add the AdChoices view.
        let adChoicesView = FBAdChoicesView(nativeAd: nativeAd)
        viewAdContainer.addSubview(adChoicesView)
        adChoicesView.updateFrameFromSuperview()
        
        
        // Use this to make the whole ad container view interact when tapping.
        // nativeAd.registerViewForInteraction(viewAdContainer, withViewController: self)
        
        // Use this to make the call-to-action interactive only.
        nativeAd.registerViewForInteraction(viewAdContainer, withViewController: self, withClickableViews: [btnAdAction])
        
        
        // Make the native ad view container visible.
        viewAdContainer.hidden = false
    }
    
    
    func handleLoadedNativeAdUsingTemplate() {
        let attributes = FBNativeAdViewAttributes()
        attributes.buttonColor = UIColor.magentaColor()
        attributes.buttonTitleColor = UIColor.yellowColor()
        attributes.backgroundColor = UIColor.purpleColor()
        attributes.titleFont = UIFont(name: "Noteworthy", size: 20.0)
        attributes.titleColor = UIColor.whiteColor()
        attributes.buttonTitleFont = UIFont(name: "Futura", size: 12.0)
        attributes.descriptionColor = UIColor.whiteColor()
        
        let nativeAdView = FBNativeAdView(nativeAd: nativeAd, withType: FBNativeAdViewType.GenericHeight300, withAttributes: attributes)
        // let nativeAdView = FBNativeAdView(nativeAd: nativeAd, withType: FBNativeAdViewType.GenericHeight300)
        nativeAdView.frame = CGRectMake(20.0, 100.0, UIScreen.mainScreen().bounds.size.width - 40.0, 300.0)
        self.view.addSubview(nativeAdView)
        
        nativeAd.registerViewForInteraction(nativeAdView, withViewController: self)
    }
    
    
    
    // MARK: FBNativeAdDelegate Methods
    
    func nativeAdDidLoad(nativeAd: FBNativeAd) {
        // handleLoadedNativeAdUsingCustomViews()
        
        handleLoadedNativeAdUsingTemplate()
    }
    
    
    func nativeAd(nativeAd: FBNativeAd, didFailWithError error: NSError) {
        print(error)
    }
    
    
    func nativeAdDidClick(nativeAd: FBNativeAd) {
        print("Did tap on the ad")
    }
    
}
