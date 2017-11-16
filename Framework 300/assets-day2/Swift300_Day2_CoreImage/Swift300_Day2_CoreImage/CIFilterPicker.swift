//
//  CIFilterPicker.swift
//  Swift300_Day2_CoreImage
//
//  Created by Nilo on 09/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

@objc protocol CIFilterPickerDelegate {
    func filterChanged()
}

class CIFilterPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource{
    

    enum Filter : String {
        case CIBloom, CIComicEffect, CIKaleidoscope
        case none = "None"
    }
    
    @IBOutlet var filterDelegate:CIFilterPickerDelegate? = nil
    
    var allFilters:[Filter] = [
        .CIBloom, .CIComicEffect, .CIKaleidoscope, .none
    ]
    
    var selectedFilter:Filter {
        return allFilters[selectedRow(inComponent: 0)]
    }

    override func didMoveToSuperview() {
        self.delegate = self
        self.dataSource = self
    }
    
    // Picker datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allFilters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UILabel()
        view.text = allFilters[row].rawValue
        view.font = UIFont(name: "AmericanTypewriter-Bold", size: 12)
        view.textColor = UIColor.green
        view.textAlignment = .center
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.filterDelegate?.filterChanged()
    }

}
