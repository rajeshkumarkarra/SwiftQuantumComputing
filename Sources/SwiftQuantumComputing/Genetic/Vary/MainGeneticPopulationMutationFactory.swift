//
//  MainGeneticPopulationMutationFactory.swift
//  SwiftQuantumComputing
//
//  Created by Enrique de la Torre on 23/02/2019.
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

struct MainGeneticPopulationMutationFactory {

    // MARK: - Private properties

    private let fitness: Fitness
    private let factory: GeneticCircuitMutationFactory
    private let score: GeneticCircuitScore

    // MARK: - Internal init methods

    init(fitness: Fitness, factory: GeneticCircuitMutationFactory, score: GeneticCircuitScore) {
        self.fitness = fitness
        self.factory = factory
        self.score = score
    }
}

// MARK: - GeneticPopulationMutationFactory methods

extension MainGeneticPopulationMutationFactory: GeneticPopulationMutationFactory {
    func makeMutation(qubitCount: Int,
                      tournamentSize: Int,
                      maxDepth: Int,
                      evaluator: GeneticCircuitEvaluator,
                      gates: [Gate]) throws -> GeneticPopulationMutation {
        let mutation = try factory.makeMutation(qubitCount: qubitCount,
                                                maxDepth: maxDepth,
                                                gates: gates)

        return try MainGeneticPopulationMutation(tournamentSize:tournamentSize,
                                                 fitness: fitness,
                                                 mutation: mutation,
                                                 evaluator: evaluator,
                                                 score: score)
    }
}