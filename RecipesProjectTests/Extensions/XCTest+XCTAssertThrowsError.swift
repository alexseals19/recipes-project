//
//  XCTest+XCTAssertThrowsError.swift
//  RecipesProjectTests
//
//  Created by Alex Seals on 11/15/24.
//  https://www.wwt.com/article/unit-testing-on-ios-with-async-await
//

import XCTest

public extension XCTest {
    func XCTAssertThrowsError<T>(
        _ expression: @autoclosure () throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (_ error: Error) -> Void = { _ in }
    ) {
        do {
            _ = try expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}

// MARK: Async XCTAssertThrowsError

public extension XCTest {
    func XCTAssertThrowsError<T>(
        _ expression: @autoclosure () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (_ error: Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}
