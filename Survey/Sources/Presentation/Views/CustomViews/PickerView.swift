//
//  PickerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct PickerView: UIViewRepresentable {

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

        var parent: PickerView

        init(_ pickerView: PickerView) {
            parent = pickerView
        }

        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 56.0
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            parent.data.count
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            parent.data[component].count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            parent.data[component][row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            parent.selections[component] = row
        }
    }

    @Binding var selections: [Int]

    var data: [[String]]

    func makeCoordinator() -> PickerView.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<PickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)

        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<PickerView>) {
        if !view.subviews.isEmpty {
            view.subviews[1].alpha = 0.0
        }
    }
}
