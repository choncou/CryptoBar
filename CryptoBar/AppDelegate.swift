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
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(60)
    var timer: NSTimer!
    let realmHelper = RealmHelper()
    var storeUpdateNotification: NotificationToken?
    let realm = try! Realm()
    
//MARK: IBOutlet
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    @IBOutlet weak var btcValueMenuItem: NSMenuItem!
    
//MARK: IBAction
    @IBAction func donateButton(sender: NSMenuItem) {
        aboutWindow.window?.makeKeyAndOrderFront(self)
        NSApp.activateIgnoringOtherApps(true)
        aboutWindow.showWindow(self)
    }
    
    /**
     Button to open Poloniex website
     */
    @IBAction func openPoloniexButton(sender: NSMenuItem) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://www.poloniex.com/exchange#btc_eth")!)
    }
    
    /**
     Button to quit the app
     */
    @IBAction func quitButton(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    /**
     Set Icon for statusItem
     */
    func setIcon(){
        let etherIcon = NSImage(named: "EtherIcon")
        etherIcon?.template = true
        
        statusItem.image = etherIcon
    }
    /**
     Set increase or decrease image for Percentage change
     */
    func setChangeIcon(percent_change: Float){
        let downIcon = NSImage(named: "downIcon")
        let upIcon = NSImage(named: "upIcon")
        
        if percent_change > 0 {
            btcValueMenuItem.image = upIcon
        } else {
            btcValueMenuItem.image = downIcon
        }
    }
    
    /**
     Update price values in menu
     */
    func updateUI() {
        let tickerStore = realmHelper.getPrice(.ETH)
        guard let store = tickerStore else {
            return
        }
        let roundedPrice = String(format: "%.2f", store.price)
        let roundedChange = String(format: "%.2f", store.percent_change_24h)
        setChangeIcon(store.percent_change_24h)
        statusItem.title = "$\(roundedPrice)"
        btcValueMenuItem.title = "\(roundedChange)%"
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 3,
            
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
        
        self.startTimer()
        self.startNotifications()
        
        self.setIcon()
        statusItem.menu = statusMenu
    }
    
    //MARK: Notifications
    
    func applicationWillTerminate(notification: NSNotification) {
        timer.invalidate()
        
        guard storeUpdateNotification != nil else {
            return
        }
        storeUpdateNotification?.stop()
    }
    
    func startNotifications() {
        
        /**
         *  Start a realmNotification to UpdateUI everytime new data is saved
         */
        let results = realm.objects(TickerStore).filter("symbol = '\(Currencies.ETH.rawValue)'")
        storeUpdateNotification = results.addNotificationBlock { notification, realm in
            self.updateUI()
        }
    }
    
    func getNewPrice() {
        CoinMarketHelper().getAllPrices()
    }
    
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(320, target: self, selector: #selector(AppDelegate.getNewPrice), userInfo: nil, repeats: true)
        timer.fire()
    }


}

