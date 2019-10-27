//
//  UnitaryGateAdapter.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 17/10/2019.
//  Copyright © 2019 Enrique de la Torre. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

// MARK: - Main body

struct UnitaryGateAdapter {

    // MARK: - UnitaryGate properties

    var unitary: Matrix {
        return quantumGate.matrix
    }

    // MARK: - Private properties

    private let quantumGate: QuantumGate
    private let gateFactory: SimulatorQuantumGateFactory

    // MARK: - Internal init methods

    init(quantumGate: QuantumGate, gateFactory: SimulatorQuantumGateFactory) {
        self.quantumGate = quantumGate
        self.gateFactory = gateFactory
    }
}

// MARK: - UnitaryGate methods

extension UnitaryGateAdapter: UnitaryGate {
    func applying(_ gate: SimulatorGate) throws -> UnitaryGateAdapter {
        let components = try gate.extract()

        let otherQuantumGate = try gateFactory.makeGate(qubitCount: quantumGate.qubitCount,
                                                        matrix: components.matrix,
                                                        inputs: components.inputs)
        let nextQuantumGate = try quantumGate.applying(otherQuantumGate)

        return UnitaryGateAdapter(quantumGate: nextQuantumGate, gateFactory: gateFactory)
    }
}