//
//  OracleGateFactory.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 13/01/2019.
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
import os.log

// MARK: - Main body

public struct OracleGateFactory {

    // MARK: - Private properties

    private let truthTable: [String]
    private let truthTableQubitCount: Int

    // MARK: - Private class properties

    private static let logger = LoggerFactory.makeLogger()

    // MARK: - Public init methods

    public init(truthTable: [String], truthTableQubitCount: Int) {
        self.truthTable = truthTable
        self.truthTableQubitCount = truthTableQubitCount
    }
}

// MARK: - CircuitGateFactory methods

extension OracleGateFactory: CircuitGateFactory {
    public func makeGate(inputs: [Int]) -> Gate? {
        guard truthTableQubitCount > 0 else {
            os_log("makeGate: unable to produce an oracle gate with 0 qubits (check truth table)",
                   log: OracleGateFactory.logger,
                   type: .debug)

            return nil
        }

        guard inputs.count >= (truthTableQubitCount + 1) else {
            os_log("makeGate: not enough inputs to produce an oracle gate",
                   log: OracleGateFactory.logger,
                   type: .debug)

            return nil
        }

        return Gate.oracle(truthTable: truthTable,
                           target: inputs[truthTableQubitCount],
                           controls: Array(inputs[0..<truthTableQubitCount]))
    }
}
