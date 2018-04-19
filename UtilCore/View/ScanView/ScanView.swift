//
//  ScanView.swift
//  MikerShoppingApp
//
//  Created by eme on 2016/11/1.
//  Copyright © 2016年 eme. All rights reserved.
//

import UIKit

class ScanView: UIView {
    
    //扫码区域
    var scanRetangleRect:CGRect = CGRect.zero
    //启动相机时 菊花等待
    var activityView:UIActivityIndicatorView?
    //启动相机中的提示文字
    var labelReadying:UILabel?
    
    //记录动画状态
    var isAnimationing:Bool = false
    
    //两边距离
    let XRetangleLeft :CGFloat = 60.0
    

    

    override func awakeFromNib() {
        
        backgroundColor = UIColor.clear
    }
    
    /**
     *  开始扫描动画
     */
    func startScanAnimation()
    {
        if isAnimationing
        {
            return
        }
        isAnimationing = true
        

    }
    
    /**
     *  开始扫描动画
     */
    func stopScanAnimation()
    {
        isAnimationing = false
        
    }
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation
    
    override func draw(_ rect: CGRect) {
        drawScanRect()
        
        
    }
    //MARK:----- 绘制扫码效果-----
    func drawScanRect()
    {
        
        let sizeRetangle = CGSize(width: self.frame.size.width - XRetangleLeft*2.0, height: self.frame.size.width - XRetangleLeft*2.0)
        
        //扫码区域Y轴最小坐标
        let YMinRetangle = self.frame.size.height/2.0 - sizeRetangle.height/2.0 - 40
        let YMaxRetangle = YMinRetangle + sizeRetangle.height
        let XRetangleRight = self.frame.size.width - XRetangleLeft
        
        let context:CGContext? = UIGraphicsGetCurrentContext()
        
        if let context = context{
            //非扫码区域半透明
            //设置非识别区域颜色
            context.setFillColor(red: 0.0, green: 0.0,
                                 blue: 0.0, alpha: 0.5)
            
            //填充矩形
            //扫码区域上面填充
            var rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: YMinRetangle)
        
            context.fill(rect)
            
            
            //扫码区域左边填充
            rect = CGRect(x: 0, y: YMinRetangle, width: XRetangleLeft, height: sizeRetangle.height)
            context.fill(rect)
            
            //扫码区域右边填充
            rect = CGRect(x: XRetangleRight, y: YMinRetangle, width: XRetangleLeft, height: sizeRetangle.height)
            context.fill(rect)
            
            //扫码区域下面填充
            rect = CGRect(x: 0, y: YMaxRetangle, width: self.frame.size.width, height: self.frame.size.height - YMaxRetangle)
            context.fill(rect)
            //执行绘画
            context.strokePath()
        }
        
        if let context = context{
            //中间画矩形(正方形)
            context.setStrokeColor(UIColor.white.cgColor)
            context.setLineWidth(1);
            
            context.addRect(CGRect(x: XRetangleLeft, y: YMinRetangle, width: sizeRetangle.width, height: sizeRetangle.height))
            
            //CGContextMoveToPoint(context, XRetangleLeft, YMinRetangle);
            //CGContextAddLineToPoint(context, XRetangleLeft+sizeRetangle.width, YMinRetangle);
            
            context.strokePath()
        }
        
        scanRetangleRect = CGRect(x: XRetangleLeft, y: YMinRetangle, width: sizeRetangle.width, height: sizeRetangle.height)
        
        
        //画矩形框4格外围相框角
        
        //相框角的宽度和高度
        let wAngle:CGFloat = 24.0
        let hAngle:CGFloat = 24.0
        
        //4个角的 线的宽度
        let linewidthAngle:CGFloat = 3 // 经验参数：6和4
        
        //画扫码矩形以及周边半透明黑色坐标参数
        let diffAngle:CGFloat = 3;
        //diffAngle = linewidthAngle / 2; //框外面4个角，与框有缝隙
        //diffAngle = linewidthAngle/2;  //框4个角 在线上加4个角效果
        //diffAngle = 0;//与矩形框重合
        
        if let context = context{
            
            context.setStrokeColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor);
            context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
            
            // Draw them with a 2.0 stroke width so they are a bit more visible.
            context.setLineWidth(linewidthAngle);
            
            
            //
            let leftX = XRetangleLeft - diffAngle
            let topY = YMinRetangle - diffAngle
            let rightX = XRetangleRight + diffAngle
            let bottomY = YMaxRetangle + diffAngle
//            CGContextMoveToPoint
            
            //左上角水平线
//            CGContextMoveToPoint(context, leftX-linewidthAngle/2, topY)
//            CGContextAddLineToPoint(context, leftX + wAngle, topY)
            context.move(to: CGPoint(x: leftX-linewidthAngle/2, y: topY))
            context.addLine(to: CGPoint(x: leftX + wAngle, y: topY))
            //左上角垂直线
//            CGContextMoveToPoint(context, leftX, topY-linewidthAngle/2)
//            CGContextAddLineToPoint(context, leftX, topY+hAngle)
            context.move(to: CGPoint(x: leftX, y: topY-linewidthAngle/2))
            context.addLine(to: CGPoint(x: leftX , y: topY+hAngle))
            
            //左下角水平线
//            CGContextMoveToPoint(context, leftX-linewidthAngle/2, bottomY)
//            CGContextAddLineToPoint(context, leftX + wAngle, bottomY)
            context.move(to: CGPoint(x: leftX-linewidthAngle/2, y: bottomY))
            context.addLine(to: CGPoint(x: leftX + wAngle , y: bottomY))
            //左下角垂直线
//            CGContextMoveToPoint(context, leftX, bottomY+linewidthAngle/2)
//            CGContextAddLineToPoint(context, leftX, bottomY - hAngle)
            context.move(to: CGPoint(x: leftX, y: bottomY+linewidthAngle/2))
            context.addLine(to: CGPoint(x: leftX , y: bottomY - hAngle))
            
            //右上角水平线
//            CGContextMoveToPoint(context, rightX+linewidthAngle/2, topY)
//            CGContextAddLineToPoint(context, rightX - wAngle, topY)
            context.move(to: CGPoint(x: rightX+linewidthAngle/2, y: topY))
            context.addLine(to: CGPoint(x: rightX - wAngle , y: topY))
            
            //右上角垂直线
//            CGContextMoveToPoint(context, rightX, topY-linewidthAngle/2)
//            CGContextAddLineToPoint(context, rightX, topY + hAngle)
            context.move(to: CGPoint(x: rightX, y: topY-linewidthAngle/2))
            context.addLine(to: CGPoint(x: rightX , y: topY + hAngle))
            
            
            //右下角水平线
//            CGContextMoveToPoint(context, rightX+linewidthAngle/2, bottomY)
//            CGContextAddLineToPoint(context, rightX - wAngle, bottomY)
            context.move(to: CGPoint(x: rightX+linewidthAngle/2, y: bottomY))
            context.addLine(to: CGPoint(x: rightX - wAngle , y: bottomY))
            //右下角垂直线
//            CGContextMoveToPoint(context, rightX, bottomY+linewidthAngle/2)
//            CGContextAddLineToPoint(context, rightX, bottomY - hAngle)
            context.move(to: CGPoint(x: rightX, y: bottomY+linewidthAngle/2))
            context.addLine(to: CGPoint(x: rightX , y: bottomY - hAngle))
            context.strokePath()
            
        }
    }
    
    
}
