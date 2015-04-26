//
//  ViewController.swift
//  Paper Wallet Checker
//
//  Created by Fabian Lachman on 25/04/15.
//  Copyright (c) 2015 Fabian Lachman. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class ViewController: UIViewController, QRCodeReaderViewControllerDelegate, BalanceFetcherDelegate  {
    
    lazy var scanCounter = 0
    
    @IBOutlet weak var bitcoinAddressLabel: UILabel!
    
    var balanceTableViewController : BalanceTableViewController?
    
    lazy var reader = QRCodeReaderViewController(metadataObjectTypes: [AVMetadataObjectTypeQRCode])

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @IBAction func scanAction(sender: AnyObject) {

        var status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        if (status == AVAuthorizationStatus.Denied) {
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
            return
        }
        
        // Retrieve the QRCode content
        // By using the delegate pattern
        reader.delegate = self
        
        // Or by using the closure pattern
        reader.completionBlock = { (result: String?) in
            println(result)
        }
        
        self.balanceTableViewController?.results.removeAllObjects()
        self.balanceTableViewController?.tableView.reloadData() 
        self.bitcoinAddressLabel.text = "Paper Wallet Checker"
        
        // Presents the reader as modal form sheet
        reader.modalPresentationStyle = .FormSheet
        presentViewController(reader, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReader Delegate Methods
    
    func reader(reader: QRCodeReaderViewController, didScanResult address: String) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        NSURLSession.sharedSession().invalidateAndCancel()
        
        self.bitcoinAddressLabel.text = address
        self.scanCounter++
        
        var bcfetcher = BlockchainInfoBalanceFetcher()
        bcfetcher.delegate = self
        bcfetcher.sourceTitle = "blockchain.info"
        bcfetcher.scanCounter = self.scanCounter
        bcfetcher.fetch(address)

        
        var blockcypherBF = BlockCypherBalanceFetcher()
        blockcypherBF.delegate = self
        blockcypherBF.sourceTitle = "blockcypher.com"
        blockcypherBF.scanCounter = self.scanCounter
        blockcypherBF.fetch(address)
        
        var chainSoBF = ChainSoBalanceFetcher()
        chainSoBF.delegate = self
        chainSoBF.sourceTitle = "chain.so"
        chainSoBF.scanCounter = self.scanCounter
        chainSoBF.fetch(address)
        
        var blockstrapBF = BlockstrapBalanceFetcher()
        blockstrapBF.delegate = self
        blockstrapBF.sourceTitle = "blockstrap.com"
        blockstrapBF.scanCounter = self.scanCounter
        blockstrapBF.fetch(address)
        
//        Helloblock down?
//        var helloblockBF = HelloblockBalanceFetcher()
//        helloblockBF.delegate = self
//        helloblockBF.sourceTitle = "helloblock.io"
//        helloblockBF.scanCounter = self.scanCounter
//        helloblockBF.fetch(address)
        
        
        var blockrBF = BlockrBalanceFetcher()
        blockrBF.delegate = self
        blockrBF.sourceTitle = "blockr.io"
        blockrBF.scanCounter = self.scanCounter
        blockrBF.fetch(address)
        
        var blocktrailBF = BlocktrailBalanceFetcher()
        blocktrailBF.delegate = self
        blocktrailBF.sourceTitle = "blocktrail.io"
        blocktrailBF.scanCounter = self.scanCounter
        blocktrailBF.fetch(address)
        
        var chainBF = ChainBalanceFetcher()
        chainBF.delegate = self
        chainBF.sourceTitle = "chain.com"
        chainBF.scanCounter = self.scanCounter
        chainBF.fetch(address)
        
        var biteasyBF = BiteasyBalanceFetcher()
        biteasyBF.delegate = self
        biteasyBF.sourceTitle = "biteasy.com"
        biteasyBF.scanCounter = self.scanCounter
        biteasyBF.fetch(address)
        
        var insightBitpayBF = InsightBitpayBalanceFetcher()
        insightBitpayBF.delegate = self
        insightBitpayBF.sourceTitle = "insight.bitpay.com"
        insightBitpayBF.scanCounter = self.scanCounter
        insightBitpayBF.fetch(address)
        
        var toshiBF = ToshiBalanceFetcher()
        toshiBF.delegate = self
        toshiBF.sourceTitle = "toshi.io"
        toshiBF.scanCounter = self.scanCounter
        toshiBF.fetch(address)
        
        var localbitcoinsBF = LocalBitcoinsBalanceFetcher()
        localbitcoinsBF.delegate = self
        localbitcoinsBF.sourceTitle = "localbitcoins.com"
        localbitcoinsBF.scanCounter = self.scanCounter
        localbitcoinsBF.fetch(address)
        
        var blockBF = BlockBalanceFetcher()
        blockBF.delegate = self
        blockBF.sourceTitle = "block.io"
        blockBF.scanCounter = self.scanCounter
        blockBF.fetch(address)
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didReceiveBalance(balance : String, scanCounter: Int, sender: BalanceFetcher) {
        if (self.scanCounter == scanCounter) {
            println("Source: \(sender.sourceTitle), Amount: \(balance)")
            self.balanceTableViewController?.addResult(balance, source: sender.sourceTitle)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.balanceTableViewController?.tableView.reloadData()
            })
        }
        else {
            println("Old scan - Source: \(sender.sourceTitle), Amount: \(balance)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "1") {
             self.balanceTableViewController = segue.destinationViewController as? BalanceTableViewController
        }
    }


}

