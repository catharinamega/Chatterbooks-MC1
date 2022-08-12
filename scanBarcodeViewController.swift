//
//  scanControllerViewController.swift
//  Mini Challenge 1 Team 4
//
//  Created by Catharina Adinda Mega Cahyani on 10/04/22.
//

import UIKit
import AVFoundation
protocol scanBarcodeProtocol {
    func back_to_prompt()
}

class scanBarcodeViewController: UIViewController {
        
    @IBOutlet weak var cameraView: UIView!
    
    
    @IBOutlet weak var flashButton: UIButton!
    
    var delegate:scanBarcodeProtocol?

// session, capturePhotoOutput, captureVidePreviewLayer
//tanda seru untuk menyatakan variabel ini pasti ada isinya, ketika lupa diisi akan diforce close
//tanda tanya opsional, kalau tidak diisi value, tidak akan diforce-close
    var captureSession:AVCaptureSession!
    var imageOutput:AVCapturePhotoOutput!
    var videoPreview:AVCaptureVideoPreviewLayer!
    var deviceInput:AVCaptureDeviceInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.layer.cornerRadius = 30
        cameraView.layer.borderWidth = 1
        cameraView.layer.borderColor = UIColor.black.cgColor
        cameraView.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let byCamera = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do{
            imageOutput = AVCapturePhotoOutput()
            captureSession = AVCaptureSession()
            captureSession.sessionPreset = .high
            deviceInput = try AVCaptureDeviceInput(device: byCamera)
            if captureSession.canAddInput(deviceInput) && captureSession.canAddOutput(imageOutput){
                captureSession.addInput(deviceInput)
                captureSession.addOutput(imageOutput)
                setLivePreview()
               
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "bookIdentity") as! bookIdentityViewController
                    vc.delegate = self
                    self.present(vc, animated: true)
                }
            }
            
        }catch let error{
            print(error.localizedDescription)
        }
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession.stopRunning()
    }
    
//    akan dipanggil ketika nambahin input dan output
    func setLivePreview(){
        videoPreview = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreview.videoGravity = .resizeAspectFill
        videoPreview.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(videoPreview)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreview.frame = self.cameraView.bounds
            }

        }
        
        

        
        
    }
    
    
    
    
    @IBAction func flashButtonClicked(_ sender: Any) {
        guard deviceInput.device.hasTorch else{return}
        if deviceInput.device.torchMode == .on{
            turnOffTorch()
        }
        else if deviceInput.device.torchMode == .off{
            turnOnTorch()
        }
        
    }
//    lock untuk flash tidak otomatis mati
//    block untuk binding data
    func lockTorch(device:AVCaptureDevice, block:(AVCaptureDevice) -> Void) {
        do{
            try device.lockForConfiguration()
            block(device)
//            default unlock, makanya lock
            device.unlockForConfiguration()
        }
        catch let error{
            print(error.localizedDescription)
        }
    }

    
    func turnOnTorch(){
        lockTorch(device: deviceInput.device) {  torch in
//            $0 merupakan return value dari sebuah function
            
            try? torch.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
        }
    }
    
    func turnOffTorch() {
        lockTorch(device: deviceInput.device) { torch in
            torch.torchMode = .off
            
        }
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

extension scanBarcodeViewController:bookIdentityProtocol{
    func correct_book() {
        self.delegate?.back_to_prompt()
        self.navigationController?.popViewController(animated: true)
        
        
//        kalau pakai modal pake di bawah ini untuk hilangin halamannya
//        dismiss(animated: true)
    }
    
    
}
