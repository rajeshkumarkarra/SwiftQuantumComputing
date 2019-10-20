//
//  RegisterGate.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 11/08/2018.
//  Copyright © 2018 Enrique de la Torre. All rights reserved.
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

struct RegisterGate {

    // MARK: - Internal properties

    let matrix: Matrix

    var qubitCount: Int {
        return Int.log2(matrix.rowCount)
    }

    // MARK: - Internal init methods

    init(matrix: Matrix) throws {
        guard matrix.isUnitary(accuracy: Constants.accuracy) else {
            throw GateError.gateMatrixIsNotUnitary
        }

        self.matrix = matrix
    }
}

// MARK: - Equatable methods

extension RegisterGate: Equatable {
    static func ==(lhs: RegisterGate, rhs: RegisterGate) -> Bool {
        return (lhs.matrix == rhs.matrix)
    }
}

// MARK: - Private body

private extension RegisterGate {

    // MARK: - Constants

    enum Constants {
        static let accuracy = 0.001
    }
}
