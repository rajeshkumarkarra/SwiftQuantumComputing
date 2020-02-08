//
//  UnitarySimulatorFacade.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 16/10/2019.
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

struct UnitarySimulatorFacade {

    // MARK: - Private properties

    private let gateFactory: UnitaryGateFactory

    // MARK: - Internal init methods

    init(gateFactory: UnitaryGateFactory) {
        self.gateFactory = gateFactory
    }
}

// MARK: - UnitarySimulator methods

extension UnitarySimulatorFacade: UnitarySimulator {
    func unitary(with circuit: [SimulatorGate], qubitCount: Int) throws -> Matrix {
        guard !circuit.isEmpty else {
            throw UnitaryError.circuitCanNotBeAnEmptyList
        }

        var unitaryGate: UnitaryGate?
        for gate in circuit {
            do {
                unitaryGate = (unitaryGate == nil ?
                    try gateFactory.makeGate(qubitCount: qubitCount, simulatorGate: gate) :
                    try unitaryGate!.applying(gate))
            } catch {
                if let error = error as? GateError {
                    throw UnitaryError.gateThrowedError(gate: gate.gate, error: error)
                } else {
                    fatalError("Unexpected error: \(error).")
                }
            }
        }

        return unitaryGate!.unitary()
    }
}
