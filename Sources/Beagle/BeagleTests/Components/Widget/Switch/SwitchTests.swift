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

import XCTest
@testable import Beagle

final class SwitchTests: XCTestCase {
    
    private let snapshotSize = CGSize(width: 150, height: 50)
    
    private lazy var controller = BeagleControllerStub()
    private lazy var renderer = BeagleRenderer(controller: controller)

    func testCodableExample() throws {
        let component: Switch = try componentFromJsonFile(fileName: "switchComponent")
        assertSnapshotJson(matching: component)
    }
    
    func testActionTriggered() {
        // Given
        let action = ActionSpy()
        let button = Switch(
            isOn: .value(false),
            enabled: .value(true),
            onToggle: [action]
        )

        // When
        let view = renderer.render(button) as? Switch.BeagleUISwitch
        view?.valueChanged()

        // Then
        XCTAssertEqual(action.executionCount, 1)
        XCTAssert(action.lastOrigin as AnyObject === view)
    }
    
    func testIsOnState() throws {
        try switchShouldBePropertySetWith(isOn: true)
        try switchShouldBePropertySetWith(isOn: false)
    }
    
    func testSetEnabledState() throws {
        try switchShouldBeProperlySetWith(enabled: true)
        try switchShouldBeProperlySetWith(enabled: false)
        try switchShouldBeProperlySetWith(enabled: nil)
    }
    
    private func switchShouldBePropertySetWith(isOn: Bool) throws {
        // Given
        let component = Switch(isOn: .value(isOn), enabled: .value(true))

        // When
        let uiSwitch = try XCTUnwrap(renderer.render(component) as? UISwitch)

        // Then
        XCTAssertEqual(uiSwitch.isOn, isOn)
    }

    private func switchShouldBeProperlySetWith(enabled: Bool?) throws {
        // Given
        let component = Switch(isOn: .value(true), enabled: .value(enabled ?? true))

        // When
        let uiSwitch = try XCTUnwrap(renderer.render(component) as? UISwitch)

        // Then
        XCTAssertEqual(uiSwitch.isEnabled, enabled ?? true)
    }

}
