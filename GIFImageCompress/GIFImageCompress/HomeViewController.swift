//
//  HomeViewController.swift
//  GIFImageCompress
//
//  Created by hanbo on 2019/2/26.
//  Copyright © 2019 hanbo. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    /// 压缩的最大值
    var compressedSize:Int = 200
    
    private lazy var gifImageView: UIImageView = {
        let gifImageView = UIImageView()
        gifImageView.backgroundColor = UIColor.red
        return gifImageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle("压缩gif", for: .normal)
        button.addTarget(self, action:#selector(clickBtn), for: .touchUpInside)
        return button
    }()
    
    private lazy var originalLabel: UILabel = {
        let originalLabel = UILabel()
        originalLabel.text = "原图大小:"
        originalLabel.backgroundColor = UIColor.red
        originalLabel.textColor = UIColor.white
        return originalLabel
    }()
    
    private lazy var compressLabel: UILabel = {
        let compressLabel = UILabel()
        compressLabel.text = "压缩后图大小:"
        compressLabel.backgroundColor = UIColor.red
        compressLabel.textColor = UIColor.white
        return compressLabel
    }()
    
    /// 压缩到
    private lazy var adjustLabel: UILabel = {
        let adjustLabel = UILabel()
        adjustLabel.text = "压缩最大值: 200KB"
        adjustLabel.textColor = UIColor.red
        return adjustLabel
    }()
    
    /// 调整压缩的最大尺寸
    private lazy var adjustSizeSlider: UISlider = {
        let adjustSizeSlider = UISlider()
        adjustSizeSlider.minimumValue = 200;
        adjustSizeSlider.maximumValue = 1000;
        //设置Slider两边槽的颜色
        adjustSizeSlider.minimumTrackTintColor = UIColor.red
        adjustSizeSlider.maximumTrackTintColor = UIColor.green
        adjustSizeSlider.addTarget(self, action: #selector(adjustSizeChange), for: .valueChanged)
        return adjustSizeSlider
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "gif图片压缩"
        createrSubViews()
        getGifBytes()
    }
    
    // 创建子View
    func createrSubViews() {
        
        view.addSubview(button)
        view.addSubview(gifImageView)
        view.addSubview(originalLabel)
        view.addSubview(compressLabel)
        view.addSubview(adjustLabel)
        view.addSubview(adjustSizeSlider)
        
        gifImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-20)
        }
        
        button.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        })
        
        originalLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(button.snp.centerX)
            make.width.equalTo(200)
            make.top.equalTo(button.snp.bottom).offset(30)
            make.height.equalTo(40)
        }
        
        compressLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(originalLabel.snp.centerX)
            make.width.equalTo(200)
            make.top.equalTo(originalLabel.snp.bottom).offset(30)
            make.height.equalTo(40)
        }
        
        adjustLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(compressLabel.snp.bottom).offset(30)
            make.width.equalTo(300)
        }
        
        adjustSizeSlider.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(adjustLabel.snp.bottom).offset(30)
            make.width.equalTo(300)
        }
    }
}

extension HomeViewController {
    
    /// 获取gif图片大小
    func getGifBytes() {
        
        let filePath = Bundle.main.path(forResource: "demo", ofType: "gif")
        let data = NSData.init(contentsOfFile: filePath ?? "")

        let str = data?.transformedValue()
        
        originalLabel.text = "原图大小: \(str ?? "")"
        gifImageView.image = UIImage.sd_image(withGIFData: data as Data?)
    }
    
    
    /// 压缩图片
    @objc func clickBtn() {
        
        let filePath = Bundle.main.path(forResource: "demo", ofType: "gif")
        let data = NSData.init(contentsOfFile: filePath ?? "")
        
        // gif图片压缩到200KB以下
        let imageData = ImageCompress.compressImageData(data! as Data, limitDataSize: Int(compressedSize * 1024))
        
        gifImageView.image = UIImage.sd_image(withGIFData: imageData as Data?)
        let newData = imageData! as NSData
        let str = newData.transformedValue()

        compressLabel.text = "压缩后大小: \(str)"
    }
    
    
    /// 调整滑竿大小
    @objc func adjustSizeChange() {
        compressedSize = Int(adjustSizeSlider.value)
        adjustLabel.text = "压缩最大值: \(compressedSize)KB"
    }
    
}
