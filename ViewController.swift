//
//  ViewController.swift
//  CALayerPlayground
//
//  Created by LYG on 15/3/20.
//  Copyright (c) 2015年 cndatacom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var viewForLayer: UIView!
    
    
    
    var L1: CALayer{
        return viewForLayer.layer;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpLayer()
    }
    
    func setUpLayer(){
        //背景色
        L1.backgroundColor = UIColor.blueColor().CGColor
        //边框款及颜色
        L1.borderWidth = 70.0
        L1.borderColor = UIColor.redColor().CGColor
        //阴影
        L1.shadowOpacity = 0.7
        L1.shadowRadius = 10.0
        
        //设置图片为背景色
        L1.contents = UIImage(named: "image2.jpg")?.CGImage
        L1.contentsGravity = kCAGravityCenter
        L1.masksToBounds = true //设置图片裁剪
    }

    //因为图层Layer本身只能响应点击测试（hitTest(_:)），不能响应手势识别，所以这里我们添加了轻触手势识别器
    @IBAction func tapGRAction(sender: UITapGestureRecognizer) {
        L1.shadowOpacity = L1.shadowOpacity == 0.7 ? 0.0 : 0.7
    }
    
    
    @IBAction func pinchGRAction(sender: UIPinchGestureRecognizer) {
        let offset: CGFloat = sender.scale < 1 ? 5.0 : -5.0
        let oldFrame = L1.frame;
        let oldOrigin = oldFrame.origin
        let newOrigin = CGPoint(x: oldOrigin.x + offset, y:oldOrigin.y + offset)
        let newSize = CGSize(width: oldFrame.width + (offset * -2.0), height: oldFrame.height + (offset * -2.0))
        let newFrame = CGRect(origin: newOrigin, size: newSize)
        if newFrame.width >= 130.0 && newFrame.width <= 250.0{
            L1.borderWidth -= offset
            //图层的边角半径默认值为0，意即标准的90度直角。增大半径会产生圆角，如果想将图层变成圆形，可以设边角半径为宽度的一半。
            L1.cornerRadius += (offset / 2.0)
            L1.frame = newFrame
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

