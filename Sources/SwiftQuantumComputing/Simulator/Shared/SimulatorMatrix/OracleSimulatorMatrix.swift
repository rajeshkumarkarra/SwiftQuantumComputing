//
//  OracleSimulatorMatrix.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 31/10/2020.
//  Copyright © 2020 Enrique de la Torre. All rights reserved.
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

import ComplexModule
import Foundation

// MARK: - Main body

struct OracleSimulatorMatrix {

    // MARK: - SimulatorMatrix properties

    let count: Int

    // MARK: - Private properties

    private let activatedSections: Set<Int>
    private let controlledMatrix: SimulatorMatrix
    private let controlledMatrixSize: Int

    // MARK: - Internal init methods

    init(truthTable: [String], controlCount: Int, controlledMatrix: SimulatorMatrix) {
        activatedSections = OracleSimulatorMatrix.truthTableAsInts(truthTable)

        controlledMatrixSize = controlledMatrix.count
        self.controlledMatrix = controlledMatrix

        count = Int.pow(2, controlCount) * controlledMatrixSize
    }
}

// MARK: - SimulatorMatrix methods

extension OracleSimulatorMatrix: SimulatorMatrix {
    var rawMatrix: Matrix {
        return try! Matrix.makeMatrix(rowCount: count,
                                      columnCount: count,
                                      value: { self[$0, $1] }).get()
    }

    subscript(row: Int, column: Int) -> Complex<Double> {
        let section = row / controlledMatrixSize

        let isDiagonalSection = section == (column / controlledMatrixSize)
        if !isDiagonalSection {
            return .zero
        }

        if !activatedSections.contains(section) {
            return (row == column ? .one : .zero)
        }

        let sectionFirstPosition = section * controlledMatrixSize
        return controlledMatrix[row - sectionFirstPosition, column - sectionFirstPosition]
    }
}

// MARK: - Private body

private extension OracleSimulatorMatrix {

    // MARK: - Private class methods

    static func truthTableAsInts(_ truthTable: [String]) -> Set<Int> {
        var result: Set<Int> = []

        for truth in truthTable {
            guard let truthAsInt = Int(truth, radix: 2) else {
                continue
            }

            result.update(with: truthAsInt)
        }

        return result
    }
}
