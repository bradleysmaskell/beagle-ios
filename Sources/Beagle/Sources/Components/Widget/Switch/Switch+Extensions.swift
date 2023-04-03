//
/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

extension Switch {
    public func toView(renderer: BeagleRenderer) -> UIView {
        let sduiSwitch = BeagleUISwitch(
            onToggle: onToggle,
            controller: renderer.controller
        )
        
        renderer.observe(tintColor, andUpdateManyIn: sduiSwitch) {
            if let tintColorString = $0, let tintColor = UIColor(hex: tintColorString) {
                sduiSwitch.tintColor = tintColor
                sduiSwitch.onTintColor = tintColor
            }
        }
        
        renderer.observe(isOn, andUpdateManyIn: sduiSwitch) {
            if let initialOnState = $0 {
                sduiSwitch.setOn(initialOnState, animated: false)
            }
        }
        
        renderer.observe(enabled, andUpdateManyIn: sduiSwitch) {
            if let isEnabled = $0 {
                sduiSwitch.isEnabled = isEnabled
            }
        }
        
        return sduiSwitch
    }
    
    final class BeagleUISwitch: UISwitch {
        var styleId: String? {
            didSet { applyStyle() }
        }
        
        private var onToggle: [Action]?
        private weak var controller: BeagleController?
        
        required init(
            onToggle: [Action]?,
            controller: BeagleController?
        ) {
            super.init(frame: .zero)
            self.onToggle = onToggle
            self.controller = controller
            self.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            applyStyle()
        }
        
        @objc func valueChanged() {
            controller?.execute(
                actions: onToggle,
                with: "onToggle",
                and: .dictionary(
                    [
                        "isOn": .bool(isOn)
                    ]
                ),
                origin: self
            )
        }
        
        private func applyStyle() {
            guard let styleId = styleId else { return }
            beagle.applyStyle(for: self, styleId: styleId, with: controller)
        }
    }

    
}
