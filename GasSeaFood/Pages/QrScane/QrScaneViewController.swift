//
//  QrScaneViewController.swift
//  GasSeaFood
//
//  Created by 陳逸煌 on 2023/3/1.
//

import Foundation

import AVFoundation
import UIKit

class QRCodeScannerViewController: BaseViewController {

    var captureSession: AVCaptureSession!
    
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    let alertLabel: UILabel = .init()

    let preview: UIView = .init()
    
    let tableView = UITableView()
    
    var adapter: TableViewAdapter?
    
    var oldCode: String = ""
    
    var newCode: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewAction))
        tap.numberOfTapsRequired = 1
        
        self.view.addGestureRecognizer(tap)
        
        self.setupAVSession()
        
        self.setupPreview()
        
        self.setupTableView()
        
        self.setupRow()
                
    }
    
    @objc func viewAction() {
        self.view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (captureSession?.isRunning == false) {
            DispatchQueue.global().async {
                self.captureSession.startRunning()
            }
        }
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.isRunning == true) {
            DispatchQueue.global().async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    func setupTableView() {
        
        self.adapter = .init(self.tableView)
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.preview.bottomAnchor, constant: 10),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10)
        ])
        
        self.tableView.register(.init(nibName: "TitleTextFieldCell", bundle: nil), forCellReuseIdentifier: "TitleTextFieldCell")
        self.tableView.register(.init(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
        self.tableView.register(.init(nibName: "EmptyHeightCell", bundle: nil), forCellReuseIdentifier: "EmptyHeightCell")
        self.tableView.register(.init(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
    }
    
    func setupRow(text: String? = nil) {
        
        var rowModels: [CellRowModel] = []
        
        let numberRow = TitleTextFieldRowModel(title: "輸入瓦斯桶編號", placeHolder: "請輸入您的瓦斯桶編號") { text in
            
        }
        
        rowModels.append(numberRow)
        
        let firstAttr = NSMutableAttributedString(string: "原 瓦斯桶\n", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)
        ])
        
        if let text = text {
            
            let secondAttr = NSMutableAttributedString(string: "瓦斯桶ID: \(text)", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
            ])
            
            firstAttr.append(secondAttr)
        }
        

        
        
        let titleRow = EmptyHeightRowModel(cellHeight: 200, color: .white, attr: firstAttr)
        
        rowModels.append(titleRow)
        
        let buttonRow = ButtonCellRowModel(buttonTitle: "確認", buttonAction: {
            self.dismiss(animated: true)
        })
        
        rowModels.append(buttonRow)
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    func setupImageView() {
        
        let imageView: UIImageView = .init()
        
        imageView.image = .init(named: "focus")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.preview.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.preview.topAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: self.preview.bottomAnchor, constant: -20),
            imageView.leadingAnchor.constraint(equalTo: self.preview.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: self.preview.trailingAnchor, constant: -20),
        ])
    }
    
    func setupAlertLabel(hasOld: Bool) {
        
        for view in self.preview.subviews {
            if let view = view as? UILabel {
                view.removeFromSuperview()
            }
        }
        
        self.alertLabel.translatesAutoresizingMaskIntoConstraints = false
        self.alertLabel.text = hasOld ? "請掃新瓦斯桶!" : "請掃舊瓦斯桶!"
        self.alertLabel.textAlignment = .center
        self.alertLabel.font = .systemFont(ofSize: 24, weight: .bold)
        self.alertLabel.textColor = .lightGray
        
        self.preview.addSubview(self.alertLabel)
        
        NSLayoutConstraint.activate([
            self.alertLabel.topAnchor.constraint(equalTo: self.preview.topAnchor),
            self.alertLabel.leadingAnchor.constraint(equalTo: self.preview.leadingAnchor),
            self.alertLabel.trailingAnchor.constraint(equalTo: self.preview.trailingAnchor),
            self.alertLabel.bottomAnchor.constraint(equalTo: self.preview.bottomAnchor)
        ])
        
    }
    
    func setupPreview() {
        self.preview.layer.addSublayer(previewLayer)
        self.previewLayer.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40)
        
        self.preview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(preview)
        
        NSLayoutConstraint.activate([
            self.preview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.preview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.preview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.preview.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
        ])
        
        self.setupImageView()
        self.setupAlertLabel(hasOld: false)
    }
    
    func showAlert(success: Bool, complete: (()->())? = nil) {
        
        let alert = CustomAlertController(title: success ? "瓦斯桶配對成功" : "換桶失敗",
                                          content: success ? "已通知換桶成功" : "請重新掃描",
                                          imageName: success ? "success" : "faild",
                                          buttonTitle: "確定",
                                          dismissAction: {
            complete?()
        })
        self.present(alert, animated: true)
    }

    func found(code: String) {
        
        self.showAlert(success: true, complete: { [ weak self] in
            self?.oldCode = code
            self?.setupRow(text: code)
            self?.setupAlertLabel(hasOld: true)
            DispatchQueue.global().async {
                self?.captureSession.startRunning()
            }
        })
        
 
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject, let stringValue = readableObject.stringValue else {
                
                self.showAlert(success: false, complete: { [weak self] in
                    DispatchQueue.global().async {
                        self?.captureSession.startRunning()
                    }
                })
                return
            }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.found(code: stringValue)
        }

        
    }
    
    func setupAVSession() {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill

        
        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
}
