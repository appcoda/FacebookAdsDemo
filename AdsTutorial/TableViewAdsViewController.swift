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
    
    
    var sampleData = [String]()
    
    let adRowStep = 4
    
    var adsManager: FBNativeAdsManager!
    
    var adsCellProvider: FBNativeAdTableViewCellProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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
        tblAdsDemo.register(UINib(nibName: "SampleCell", bundle: nil), forCellReuseIdentifier: "idCellSample")
        tblAdsDemo.reloadData()
    }
    
    
    func createFakeData() {
        for i in 0..<20 {
            sampleData.append("Sample Content #\(i+1)")
        }
    }
    
    
    // MARK: UITableView Delegate and Datasource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if adsCellProvider != nil {
            return Int(adsCellProvider.adjustCount(UInt(self.sampleData.count), forStride: UInt(adRowStep)))
        }
        else {
            return sampleData.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if adsCellProvider != nil && adsCellProvider.isAdCell(at: indexPath, forStride: UInt(adRowStep)) {
            return adsCellProvider.tableView(tableView, cellForRowAt: indexPath)
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "idCellSample", for: indexPath) as! SampleCell
            cell.lblTitle.text = sampleData[indexPath.row - Int(indexPath.row / adRowStep)]
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if adsCellProvider != nil && adsCellProvider.isAdCell(at: indexPath as IndexPath, forStride: UInt(adRowStep)) {
            return adsCellProvider.tableView(tableView, heightForRowAt: indexPath as IndexPath)
        }
        else {
            return 60.0
        }
    }
    
    func configureAdManagerAndLoadAds() {
        if adsManager == nil {
            adsManager = FBNativeAdsManager(placementID: "PLACEMENT_ID", forNumAdsRequested: 5)
            adsManager.delegate = self
            adsManager.loadAds()
        }
    }
    
    // MARK: FBNativeAdsManagerDelegate Methods
    
    func nativeAdsLoaded() {
        adsCellProvider = FBNativeAdTableViewCellProvider(manager: adsManager, for: FBNativeAdViewType.genericHeight120)
        adsCellProvider.delegate = self
        
        if tblAdsDemo != nil {
            tblAdsDemo.reloadData()
        }
    }
    
    
    func nativeAdsFailedToLoadWithError(_ error: Error) {
        print(error)
    }
    
    
    
    // MARK: FBNativeAdDelegate Methods
    
    func nativeAdDidClick(_ nativeAd: FBNativeAd) {
        print("Ad tapped: \(String(describing: nativeAd.title))")
    }
}
