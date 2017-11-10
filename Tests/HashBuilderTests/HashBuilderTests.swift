/*
 MIT License
 Copyright (c) 2017 Andy Best
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import XCTest
@testable import HashBuilder

class Foo {
    
}

struct TestStruct: Hashable {
    let testInt: Int
    let testFloat: Float
    let testBool: Bool
    
    var hashValue: Int {
        let builder = HashBuilder()
        builder.appendValue(testInt)
        builder.appendValue(testFloat)
        builder.appendValue(testBool)
        print(builder.result)
        return builder.result
    }
    
    static func ==(lhs: TestStruct, rhs: TestStruct) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

class HashBuilderTests: XCTestCase {
    func testEquality() {
        let t1 = TestStruct(testInt: 1, testFloat: 2.2, testBool: true)
        let t2 = TestStruct(testInt: 1, testFloat: 2.2, testBool: true)
        
        XCTAssertEqual(t1.hashValue, t2.hashValue)
    }
    
    func testInequality() {
        let t1 = TestStruct(testInt: 1, testFloat: 2.2, testBool: false)
        let t2 = TestStruct(testInt: 1, testFloat: 2.2, testBool: true)
        
        XCTAssertNotEqual(t1.hashValue, t2.hashValue)
    }
    
    func testOverflow() {
        let builder = HashBuilder()
        builder.appendValue(UInt64.max)
        builder.appendValue(Double.greatestFiniteMagnitude)
        builder.appendValue(UInt64.max)
        builder.appendValue(Int.min)
        builder.appendValue(Double.greatestFiniteMagnitude)
        builder.appendValue(Double.greatestFiniteMagnitude)
        builder.appendValue(Double.greatestFiniteMagnitude)
        builder.appendValue(Double.greatestFiniteMagnitude)
        builder.appendValue(Double.greatestFiniteMagnitude)
        builder.appendValue(Double.greatestFiniteMagnitude)
        builder.appendValue("Hello")
        builder.appendValue(Foo())
        builder.appendValue([1, 2, 3, 4])
    }
    
    static var allTests = [
        ("testEquality", testEquality),
        ("testInequality", testInequality),
        ("testOverflow", testOverflow)
    ]
}
