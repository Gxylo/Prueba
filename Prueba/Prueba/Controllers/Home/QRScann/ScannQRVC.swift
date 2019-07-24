//
//  ScannQRVC.swift
//  Prueba
//
//  Created by Gerardo Xiloxochitl on 7/23/19.
//  Copyright © 2019 Gerardo Xiloxochitl. All rights reserved.
//

import UIKit
import AVFoundation

class ScannQRVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var lbQrCode: UILabel!
    
    @IBOutlet weak var previewContainer: UIView!
    
    @IBOutlet weak var captureCodeFrame: UIImageView!
    
    @IBOutlet weak var lbOrderID: UILabel!
    
    var order: Order?
    
    var captureSession:AVCaptureSession?
    
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    
    var qrCodeFrameView: UIView?
    
    var captureDevice: AVCaptureDevice?
    
    let supportedCodeTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.ean13 , AVMetadataObject.ObjectType.code128]
    
    var isScanCode: Bool?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupView()
    }
    
    func setupView()  {
        
        if self.order != nil {
            
            self.lbOrderID.text = "id:  \((self.order?.id)!)"
        }
        
        captureDevice = AVCaptureDevice.default(for: .video)
        
        self.isScanCode = false
        
        do {
            
            //Capture session
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            self.captureSession = AVCaptureSession()
            
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            //VideoPreview Layer
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            videoPreviewLayer?.frame = self.view.layer.bounds
            
            self.previewContainer.layer.addSublayer(videoPreviewLayer!)
            
            //Start video capture
            captureSession?.startRunning()
            
        } catch {
            
            print(error)
            return
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        isScanCode = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if (captureDevice?.hasTorch)!{
            
            do {
                try captureDevice?.lockForConfiguration()
                
                if captureDevice?.torchMode == AVCaptureDevice.TorchMode.on {
                    captureDevice?.torchMode = AVCaptureDevice.TorchMode.off
                }
                
            } catch  {
                print(error)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        
        if isScanCode! {
            
            return
        }
        
        
        //Check if metadataObjects is nil or and is diferente a empty
        if metadataObjects.count == 0 {
            
            //qrCodeFrameView?.frame = CGRect.zero
            
            //Show alert No QR/barcode is detected
            return
        }
        
        //Get metadataObject
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type){
            
            //If found metadata Object is equal to QR code metadata then update status set the bounds
            let barCodeObjetc = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            
            //qrCodeFrameView?.frame = (barCodeObjetc?.bounds)!
            
            if metadataObj.stringValue != nil {
                
                //TODO: Dev sen to back end the barcode
                self.lbQrCode.text = metadataObj.stringValue
                
                print(metadataObj.stringValue)
                
                isScanCode = true
                
            }
            
            return
        }
    }
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        
        
    }

    
    @IBAction func backToView(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
