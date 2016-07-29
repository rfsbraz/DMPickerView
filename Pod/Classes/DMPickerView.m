//
//  SkyHourWheelView.swift
//  SkyHour
//
//  Created by Elisabete Sousa on 04/07/16.
//  Copyright © 2016 SkyHour. All rights reserved.
//

import Foundation
import UIKit
import DMPickerView

protocol SkyHourWheelDelegate : NSObjectProtocol {
    
    /**
     Selected a label.
     @param value the selected value
     */
    func didSelectValue(value: UInt)
}

public enum PickerScrollOrientation : Int {
    case OrientationUp
    case OrientationDown
}

final class SkyHourWheelView: UIView, DMPickerViewDelegate, DMPickerViewDatasource {
    
    // MARK: - Outlets
    @IBOutlet weak var pickerView: DMPickerView!
    
    // MARK: - Private vars
    var skyhourWheelDelegate: SkyHourWheelDelegate!
    let pickerOrientation: PickerScrollOrientation = .OrientationDown //this is the default value

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if pickerOrientation == .OrientationDown { movePickerToIndex(99, animated: false)}
    }
    
    // MARK: - Setup
    
    func setupViews() {
        backgroundColor = UIColor.clearColor()
        
        // Vertical picker
        pickerView.datasource = self
        pickerView.delegate = self
        pickerView.spacing = -50.0
        pickerView.minSizeScale = 0.2
        pickerView.sizeScaleRatio = 1.0
        pickerView.minAlphaScale = 0.2
        pickerView.alphaScaleRatio = 1.0
        pickerView.shouldUpdateRenderingOnlyWhenSelected = false
        pickerView.reloadData()
    }
    
    // MARK: - DMPickerview
    
    @objc(numberOfLabelsForPickerView:) func numberOfLabelsForPickerView(pickerView: DMPickerView!) -> UInt {
        return 100
    }

    @objc(valueLabelForPickerView:AtIndex:) func valueLabelForPickerView(pickerView: DMPickerView!, atIndex index: UInt) -> String! {
        if pickerOrientation == .OrientationUp { return ("\(index)")}
        else { return ("\(99-index)")}
    }
    
    @objc(fontForLabelsForPickerView:AtIndex:) func fontForLabelsForPickerView(pickerView: DMPickerView!, atIndex index: UInt) -> UIFont! {
        var font = UIFont(name: "HelveticaNeue-Bold", size: 150.0)
        var index = index
        
        if pickerOrientation == .OrientationDown {
            index = (99-index)
        }
        if index > 9 {
            font = UIFont(name: "HelveticaNeue-Bold", size: 140.0)
        }
        return font
    }
    
    @objc(textColorForLabelsForPickerView:) func textColorForLabelsForPickerView(pickerView: DMPickerView!) -> UIColor! {
        return UIColor.whiteColor()
    }
    
     @objc(pickerView:didSelectLabelAtIndex:userTriggered:) func pickerView(pickerView: DMPickerView!, didSelectLabelAtIndex index: UInt, userTriggered: Bool) {
        if pickerOrientation == .OrientationUp { skyhourWheelDelegate.didSelectValue(index)}
        else { skyhourWheelDelegate.didSelectValue(99-index)}
    }
    
    @objc(heightForLabelsForPickerView:) func heightForLabelsForPickerView(pickerView: DMPickerView!) -> CGFloat {
        return 170.0
    }
    
    func movePickerToIndex(index: UInt, animated: Bool) {
        self.pickerView.moveToIndex(index, animated: animated)
    }
    
    func movePickerToFirstHour() {
        if pickerOrientation == .OrientationUp { self.pickerView.moveToIndex(1, animated: true)}
        else { self.pickerView.moveToIndex(98, animated: true)}
    }
}