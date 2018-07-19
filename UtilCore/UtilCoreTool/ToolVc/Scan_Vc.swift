//
//  Scan_Vc.swift
//  Pods
//
//  Created by eme on 2017/3/6.
//
//

/*
 owner:cy
 update:2017年03月06日10:44:50
 info: 扫一扫vc
 */

import UIKit
import AVFoundation

public class Scan_Vc: Base_Vc {
    /****************************Storyboard UI设置区域****************************/
    @IBOutlet weak var scan_Content_V: UIView!
    
    @IBOutlet weak var footer_V: UIView!
    
    @IBOutlet weak var bottom_Lb: UILabel!
    
    
    @IBOutlet weak var scan_Line_ImgV: UIImageView!
    
    @IBOutlet weak var light_Btn: UIButton!
    @IBOutlet weak var scan_Line_HeightLc: NSLayoutConstraint!
    
    @IBOutlet weak var content_V: UIView!
    
    ///上次扫描到的结果
    var lastResultStr:String?
    
    ///保存扫到的值
    public var didScanValue_Block:((_ relValue:String) -> Void)?
    /*----------------------------   自定义属性区域    ----------------------------*/
    
    ///扫描动画
    var isAnimationing:Bool = true
    var startY:CGFloat = 5.0
    var isDown:Bool = true
    /// 定时器
    var timer:Timer!
    // MARK: - 懒加载
    // 会话
    lazy var session : AVCaptureSession = AVCaptureSession()
    
    // 拿到输入设备
    lazy var deviceInput: AVCaptureDeviceInput? = {
        // 获取摄像头
        guard let device = AVCaptureDevice.default(for: .video) else{
            return nil
        }
        do{
            // 创建输入对象
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch
        {
            print(error)
            return nil
        }
    }()
    
    // 拿到输出对象
    lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    // 创建预览图层
    lazy var previewLayer: AVCaptureVideoPreviewLayer? = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.main.bounds
        return layer
    }()
    /****************************Storyboard 绑定方法区域****************************/
    
    
    
    /**************************** 以下是方法区域 ****************************/
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lastResultStr = nil
        // 2.开始扫描
        startScan()
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.stepAnimation()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier { // 检查是否 nil
            switch identifier {
            default: break
            }
        }
    }
    /**
     界面基础设置
     */
    public  override func setupUI() {
        self.tabBarController?.tabBar.isHidden = true
        /**
         *  自定义 导航栏左侧 返回按钮
         */
        self.customLeftBarButtonItem()
        self.tabBarController?.tabBar.isHidden = true
        
        // 启用计时器，控制每秒执行一次tickDown方法
        timer = Timer.scheduledTimer(timeInterval: 0.02,
                                     target:self,selector:#selector(Scan_Vc.stepAnimation),
                                     userInfo:nil,repeats:true)
        
    }
    
    /**
     绑定到viewmodel 设置
     */
    public override func bindToViewModel(){
        
    }
}
extension Scan_Vc{
    // MARK: - 扫描二维码
    func startScan(){
        guard let deviceInput = self.deviceInput else {
            return
        }
        
        // 1.判断是否能够将输入添加到会话中
        if !session.canAddInput(deviceInput)
        {
            return
        }
        // 2.判断是否能够将输出添加到会话中
        if !session.canAddOutput(output)
        {
            return
        }
        // 3.将输入和输出都添加到会话中
        session.addInput(deviceInput)
        session.addOutput(output)
        //        output.rectOfInterest = cropRect
        // 4.设置输出能够解析的数据类型
        // 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
        output.metadataObjectTypes =  output.availableMetadataObjectTypes
        // 5.设置输出对象的代理, 只要解析成功就会通知代理
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 添加预览图层,必须要插入到最下层的图层
        if let previewLayer = self.previewLayer{
            view.layer.insertSublayer(previewLayer, at: 0)
            // 6.告诉session开始扫描
            session.startRunning()
        }
        
        
    }
    @objc func stepAnimation()
    {
        if (!isAnimationing) {
            return;
        }
        
        let maxHeight:CGFloat =  self.content_V.frame.size.height
        UIView.animate(withDuration: 1.4, animations: { () -> Void in
            if self.isDown == true{
                self.startY += 2
                if self.startY >= maxHeight - 5{
                    self.isDown = false
                }else{
                    self.isDown = true
                }
                
            }else{
                self.startY -= 2
                if self.startY <= 5{
                    self.isDown = true
                }else{
                    self.isDown = false
                }
            }
            self.scan_Line_HeightLc.constant = self.startY
            
        }, completion:{ (value: Bool) -> Void in
            
            
        })
        
    }
    
    func stopStepAnimating()
    {
        isAnimationing = false;
    }
    func isGetFlash()->Bool
    {
        if (deviceInput != nil)
        {
            return true
        }
        return false
    }
    /**
     ------闪光灯打开或关闭
     */
    func changeTorch()
    {
        if isGetFlash()
        {
            do
            {
                try deviceInput?.device.lockForConfiguration()
                
                var torch = false
                
                if deviceInput?.device.torchMode == AVCaptureDevice.TorchMode.on
                {
                    torch = false
                }
                else if deviceInput?.device.torchMode == AVCaptureDevice.TorchMode.off
                {
                    torch = true
                }
                self.light_Btn.isSelected = torch
                deviceInput?.device.torchMode = torch ? AVCaptureDevice.TorchMode.on : AVCaptureDevice.TorchMode.off
                
                deviceInput?.device.unlockForConfiguration()
            }
            catch let error as NSError {
                print("device.lockForConfiguration(): \(error)")
                
            }
        }
    }
}
// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension Scan_Vc: AVCaptureMetadataOutputObjectsDelegate
{
    // 只要解析到数据就会调用
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        // 检查：metadataObjects 对象不为空，并且至少包含一个元素
        if metadataObjects.count == 0 {
            return
        }
        guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            return
        }
        // 获得元数据对象
        // 如果元数据是二维码，则更新二维码选框大小与 label 的文本
        if let stringValue =   metadataObj.stringValue {
            if self.lastResultStr != stringValue{
                if let didScanValue_Block = self.didScanValue_Block{
                    didScanValue_Block(stringValue)
                }else{
                    if stringValue.hasPrefix("https") || stringValue.hasPrefix("http") {
                        _ = stringValue.openURL()
                    }else{
                        self.view.toastCompletion(stringValue){ _ in
                            let pasteBoard = UIPasteboard.general
                            pasteBoard.string = stringValue
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
            self.lastResultStr = stringValue
        }
    }
}
