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

/// Switch is a component that displays a toggleable switch.
public struct Switch: Widget {
    
    /// Whether the Switch is toggled on
    public var isOn: Expression<Bool>
    
    /// References a native style configured to be applied on this switch.
    public var styleId: String?
    
    /// Enables or disables the switch.
    public var enabled: Expression<Bool>
    
    /// Actions array that this field can trigger when its value is toggled.
    @AutoCodable public var onToggle: [Action]?
    
    public var id: String?
    public var style: Style?
    public var accessibility: Accessibility?
}
