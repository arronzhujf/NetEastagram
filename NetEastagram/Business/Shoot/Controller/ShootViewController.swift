//
//  ShootViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/1.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import AVFoundation

class ShootViewController: BaseViewController {
    private static let previewHeightRatio: CGFloat = (Constants.SCREEN_WIDTH*3/4.0)/Constants.SCREEN_HEIGHT
    
    private var session: AVCaptureSession
    private var videoInput: AVCaptureDeviceInput? = nil
    private var stillImageOutput: AVCaptureStillImageOutput
    private var previewLayer: AVCaptureVideoPreviewLayer
    private var backView: UIView
    
    private var shootBtn: ImageTopLabelBottomButton
    private var albumBtn: ImageTopLabelBottomButton
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        backView = UIView()
        session = AVCaptureSession()
        stillImageOutput = AVCaptureStillImageOutput()
        previewLayer = AVCaptureVideoPreviewLayer()
        shootBtn = ImageTopLabelBottomButton()
        albumBtn = ImageTopLabelBottomButton()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        session.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.stopRunning()
    }
    
    //MARK: - private
    private func initInternal() {
        customBarTileViewWith(image: UIImage(named: "shoot-bar-icon"), title: Constants.POST)
        backView.frame = CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT * ShootViewController.previewHeightRatio)
        backView.backgroundColor = .gray
        backView.layer.masksToBounds = true
        view.addSubview(backView)
        
        shootBtn.setImage(UIImage(named: "shoot"), for: .normal)
        shootBtn.setImage(UIImage(named: "shoot-light"), for: .highlighted)
        shootBtn.setTitle(Constants.SHOOT, for: .normal)
        shootBtn.setTitleColor(Constants.TEXT_GRAY_COLOR, for: .normal)
        shootBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        shootBtn.addTarget(self, action: #selector(shootBtnClick(_:)), for: .touchUpInside)

        albumBtn.setImage(UIImage(named: "shoot-album"), for: .normal)
        albumBtn.setImage(UIImage(named: "shoot-album-light"), for: .highlighted)
        albumBtn.setTitle(Constants.ALBUM, for: .normal)
        albumBtn.setTitleColor(Constants.TEXT_GRAY_COLOR, for: .normal)
        albumBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        albumBtn.addTarget(self, action: #selector(albumBtnClick(_:)), for: .touchUpInside)

        view.addSubview(shootBtn)
        view.addSubview(albumBtn)
        
        shootBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(backView.height/2.0 - tabBarHeight/2.0)
            make.left.equalToSuperview().offset(72.0)
            make.height.equalTo(68)
            make.width.equalTo(36)
        }
        
        albumBtn.snp.makeConstraints { (make) in
            make.centerY.height.width.equalTo(shootBtn)
            make.right.equalToSuperview().offset(-72.0)
        }
        
        setAVCaptureSession()
    }
    
    private func setAVCaptureSession() {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        videoInput = try? AVCaptureDeviceInput(device: device)
        //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
        stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        if session.canAddInput(videoInput), session.canAddOutput(stillImageOutput) {
            session.addInput(videoInput)
            session.addOutput(stillImageOutput)
        }
        previewLayer.session = session
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.frame = backView.frame
        backView.layer.addSublayer(previewLayer)
    }
    
    //MARK: - action
    @objc func shootBtnClick(_ sender: ImageTopLabelBottomButton) {
        if let stillImageConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo) {
            stillImageConnection.videoScaleAndCropFactor = 1.0
            stillImageOutput.captureStillImageAsynchronously(from: stillImageConnection) { [weak self] (imageDataSampleBuffer, error) in
                guard let imageDataSampleBuffer = imageDataSampleBuffer, error == nil else { return }
                let jpegData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                if let jpegData = jpegData, var image = UIImage(data: jpegData)?.fixOrientation() {
                    image = image.cutImageByCoornidate(topLeft: CGPoint(x: 0, y: (1-ShootViewController.previewHeightRatio)/2.0), bottomRight: CGPoint(x: 1, y: 0.5+ShootViewController.previewHeightRatio/2.0))
                    let editVC = EditViewController()
                    editVC.image = image
                    self?.present(UINavigationController(rootViewController: editVC), animated: true, completion: nil)
                }
            }
            
        }
    }
    
    @objc func albumBtnClick(_ sender: ImageTopLabelBottomButton) {
        present(UINavigationController(rootViewController: EditViewController()), animated: true, completion: nil)
    }

}
