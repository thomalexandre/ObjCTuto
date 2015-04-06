//
//  MainViewController.swift
//  FunnyCamera
//
//  Created by Geppy Parziale on 9/10/14.
//  Copyright (c) 2014 iNVASIVECODE, Inc. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore
import CoreMedia
import Accelerate

class MainViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var backgroundView : UIView!

    var customPreviewLayer : CALayer?
    var captureSession : AVCaptureSession?
    var readyForProcessing = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCameraSession()
    }

    func setupCameraSession () {

        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetLow

        var inputDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

        var error: NSError?
        var deviceInput = AVCaptureDeviceInput.deviceInputWithDevice(inputDevice, error: &error) as AVCaptureInput

        if self.captureSession!.canAddInput(deviceInput) {
            self.captureSession!.addInput(deviceInput)
        }

        // Preview layer
        self.customPreviewLayer = CALayer()
        if let bgView = self.backgroundView {
        self.customPreviewLayer!.bounds = self.backgroundView.bounds
        let center = CGPoint(x: CGRectGetMidX(self.backgroundView.bounds), y: CGRectGetMidY(self.backgroundView.bounds))
        customPreviewLayer!.position = center
        customPreviewLayer!.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(M_PI_2)))
        self.backgroundView.layer.addSublayer(customPreviewLayer!)

        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [ kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_420YpCbCr8BiPlanarFullRange ]
        dataOutput.alwaysDiscardsLateVideoFrames = true

        if self.captureSession!.canAddOutput(dataOutput) {
            self.captureSession!.addOutput(dataOutput)
        }

        self.captureSession!.commitConfiguration()

        var queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL)

        dataOutput.setSampleBufferDelegate(self, queue: queue)

        self.captureSession!.startRunning()
        self.spinner.startAnimating()
        }
    }

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {


        if readyForProcessing {

            readyForProcessing = false

            var imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            CVPixelBufferLockBaseAddress(imageBuffer, 0)


            let width = CVPixelBufferGetWidth(imageBuffer) as size_t
            let height = CVPixelBufferGetHeight(imageBuffer) as size_t
            let bytePerRow = CVPixelBufferGetBytesPerRow(imageBuffer) as size_t

            var lumaBuffer = CVPixelBufferGetBaseAddress(imageBuffer)


            //            let inImage : vImage_Buffer = { .lumaBuffer, .height, .width, .bytesPerRow }

            
            readyForProcessing = true

        }
    }

}










