//
//  PriceSlider.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/27.
//

import UIKit

class PriceSlider: UIControl {

    private(set) var minimumValue: CGFloat = 0.011 {
        didSet {
          updateLayerFrames()
        }
    }
    private(set) var maximumValue: CGFloat = 1.0 {
        didSet {
          updateLayerFrames()
        }
    }
    private(set) var lowerValue: CGFloat = 0.011 {
        didSet {
          updateLayerFrames()
        }
    }
    private(set) var upperValue: CGFloat = 1.0 {
        didSet {
          updateLayerFrames()
        }
    }
    
    private var thumbImage = #imageLiteral(resourceName: "pause-circle")
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    
    private var previousLocation = CGPoint()
    private let trackLayer = RangeSliderTrackLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        lowerThumbImageView.image = thumbImage
        lowerThumbImageView.layer.zPosition = 1
        addSubview(lowerThumbImageView)
        
        upperThumbImageView.image = thumbImage
        upperThumbImageView.layer.zPosition = 1
        addSubview(upperThumbImageView)
    }
    
    func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: 0)
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                           size: thumbImage.size)
        upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                           size: thumbImage.size)
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - thumbImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - 12))
    }
    
    func reset() {
        lowerValue = 0.011
        upperValue = 1.0
    }
    
    func calculateAvg() -> CGFloat {
        return (lowerValue + upperValue) / 2
    }
}


extension PriceSlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        previousLocation = touch.location(in: self)
        
        if lowerThumbImageView.frame.contains(previousLocation) {
            lowerThumbImageView.isHighlighted = true
        } else if upperThumbImageView.frame.contains(previousLocation) {
            upperThumbImageView.isHighlighted = true
        }
        
        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        
        previousLocation = location
        
        if lowerThumbImageView.isHighlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                    upperValue: upperValue)
        } else if upperThumbImageView.isHighlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                    upperValue: maximumValue)
        }
        
        sendActions(for: .valueChanged)
        return true
    }
    
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat,
                            upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }
}
