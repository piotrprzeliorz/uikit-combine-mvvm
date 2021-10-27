//
//  Publisher+WithLatestFrom.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine
import Foundation

extension Publisher {

    func withLatestFrom<P>(_ other: P) -> AnyPublisher<(Self.Output, P.Output), Failure> where P: Publisher, Self.Failure == P.Failure {
        let other = other
        // Note: Do not use `.map(Optional.some)` and `.prepend(nil)`.
        // There is a bug in iOS versions prior 14.5 in `.combineLatest`. If P.Output itself is Optional.
        // In this case prepended `Optional.some(nil)` will become just `nil` after `combineLatest`.
            .map { (value: $0, ()) }
            .prepend((value: nil, ()))

        return map { (value: $0, token: UUID()) }
        .combineLatest(other)
        .removeDuplicates(by: { (old, new) in
            let lhs = old.0, rhs = new.0
            return lhs.token == rhs.token
        })
        .map { ($0.value, $1.value) }
        .compactMap { (left, right) in
            right.map { (left, $0) }
        }
        .eraseToAnyPublisher()
    }
}
