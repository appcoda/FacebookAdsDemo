//
//  TableViewAdsViewController.swift
//  AdsTutorial
//
//  Created by Gabriel Theodoropoulos on 29/07/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class TableViewAdsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FBNativeAdDelegate, FBNativeAdsManagerDelegate {

    @IBOutlet weak var tblAdsDemo: UITableView!
    
    
    let adRowStep = 4
    
    var adsManager: FBNativeAdsManager!
    
    var adsCellProvider: FBNativeAdTableViewCellProvider!
    
    
    var sampleData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        createFakeData()
        configureTableView()
        
        configureAdManagerAndLoadAds()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: Custom Methods
    
    func configureTableView() {
        tblAdsDemo.delegate = self
        tblAdsDemo.dataSource = self
        tblAdsDemo.registerNib(UINib(nibName: "SampleCell", bundle: nil), forCellReuseIdentifier: "idCellSample")
        tblAdsDemo.reloadData()
    }
    
    
    func createFakeData() {
        for i in 0..<20 {
            sampleData.append("Sample Content #\(i+1)")
        }
    }

    
    func configureAdManagerAndLoadAds() {
        if adsManager == nil {
            adsManager = FBNativeAdsManager(placementID: "PLACEMENT_ID", forNumAdsRequested: 5)
            adsManager.delegate = self
            adsManager.loadAds()
        }
    }
    
    
    
    // MARK: UITableView Delegate and Datasource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if adsCellProvider != nil {
            return Int(adsCellProvider.adjustCount(UInt(self.sampleData.count), forStride: UInt(adRowStep)))
        }
        else {
            return sampleData.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if adsCellProvider != nil && adsCellProvider.isAdCellAtIndexPath(indexPath, forStride: UInt(adRowStep)) {
            return adsCellProvider.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("idCellSample", forIndexPath: indexPath) as! SampleCell
            cell.lblTitle.text = sampleData[indexPath.row - Int(indexPath.row / adRowStep)]
            return cell
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if adsCellProvider != nil && adsCellProvider.isAdCellAtIndexPath(indexPath, forStride: UInt(adRowStep)) {
            return adsCellProvider.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
        else {
            return 60.0
        }
    }
    
    
    
    // MARK: FBNativeAdsManagerDelegate Methods
    
    func nativeAdsLoaded() {
        adsCellProvider = FBNativeAdTableViewCellProvider(manager: adsManager, forType: FBNativeAdViewType.GenericHeight120)
        adsCellProvider.delegate = self
        
        if tblAdsDemo != nil {
            tblAdsDemo.reloadData()
        }
    }
    
    
    func nativeAdsFailedToLoadWithError(error: NSError) {
        print(error)
    }
    
    
    
    // MARK: FBNativeAdDelegate Methods
    
    func nativeAdDidClick(nativeAd: FBNativeAd) {
        print("Ad tapped: \(nativeAd.title)")
    }
}
