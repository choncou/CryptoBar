//
//  AppDelegate.swift
//  CryptoBar
//
//  Created by Unathi Chonco on 2016/03/16.
//  Copyright © 2016 Unathi Chonco. All rights reserved.
//

import Cocoa
import RealmSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    lazy var aboutWindow: AboutWindowController = AboutWindowController(windowNibName: "AboutWindowController")
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var poloniexToken: NotificationToken!
    var coinMarkertToken: NotificationToken!
    var timer: NSTimer!
    let realm = try! Realm()
    
//MARK: IBOutlet
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    @IBOutlet weak var bitCoinPrice: NSMenuItem!
    
//MARK: IBAction
    @IBAction func donateButton(sender: NSMenuItem) {
        aboutWindow.window?.makeKeyAndOrderFront(self)
        NSApp.activateIgnoringOtherApps(true)
        aboutWindow.showWindow(self)
    }
    
    @IBAction func openPoloniexButton(sender: NSMenuItem) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://www.poloniex.com/exchange#btc_eth")!)
    }
    
    @IBAction func quitButton(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func startNotification(){
        poloniexToken = realm.objects(PoloniexStore).addNotificationBlock{ results, error in
            guard let results = results else{
                return
            }
            self.updateStatusBar(results)
        }
    }
    
    func showWithOldDollar(results: Results<PoloniexStore>){
        guard let dollarPrice = results.filter("title = 'USDT_ETH'").first?.last else{
            return
        }
        
        guard let ether = results.filter("title = 'BTC_ETH'").first else{
            return
        }
        var title = ether.title
        title = title.substringFromIndex(title.startIndex.advancedBy(4))
        let price = String(format: "%.2f", dollarPrice)
        let bprice = String(format: "%.4f", ether.last)
        statusItem.title = "$\(price))"
        bitCoinPrice.title = "\(title)=\(bprice) BTC"
        self.setChangeIcon()
    }
    
    func updateStatusBar(results: Results<PoloniexStore>){
        guard let dollarPrice = RealmHelper().getETHPrice() else{
            self.showWithOldDollar(results)
            return
        }
        
        guard let ether = results.filter("title = 'BTC_ETH'").first else{
            return
        }
        var title = ether.title
        title = title.substringFromIndex(title.startIndex.advancedBy(4))
        let price = String(format: "%.2f", dollarPrice)
        let bprice = String(format: "%.4f", ether.last)
        statusItem.title = "$\(price)"
        bitCoinPrice.title = "\(title)=\(bprice) BTC"
        self.setChangeIcon()
        
    }
    
    func setChangeIcon(){
        let etherIcon = NSImage(named: "EtherIcon")
        etherIcon?.template = true
        
        statusItem.image = etherIcon
//        statusItem.button?.imagePosition = .ImageLeft
        
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        //        if let path = Realm.Configuration.defaultConfiguration.path {
        //            try! NSFileManager().removeItemAtPath(path)
        //        }
        
        
        self.startTimer()
        
        self.setChangeIcon()
        statusItem.menu = statusMenu
        
        startNotification()
        
        
        // Insert code here to initialize your application
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 0,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        _ = try! Realm()
    }
    
    func applicationWillTerminate(notification: NSNotification) {
        self.stopNotification()
        timer.invalidate()
    }
    
    func stopNotification(){
        self.poloniexToken.stop()
    }
    
    func startTimer() {
        self.callTickers()
        timer = NSTimer.scheduledTimerWithTimeInterval(320, target: self, selector: Selector("callTickers"), userInfo: nil, repeats: true)
    }
    
    func callTickers(){
        PoloniexHelper().returnTickers()
    }


}

