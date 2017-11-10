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

class HashBuilder {
    
    var result: Int
    var constant: Int
    
    var calculatedHash: Int {
        return result
    }
    
    init() {
        // Initial prime values for hash and constant
        result = 17
        constant = 31
    }
    
    func appendValue<T: FixedWidthInteger>(_ value: T) {
        result = result.multipliedReportingOverflow(by: constant).partialValue
            .addingReportingOverflow(Int(truncatingIfNeeded:value)).partialValue
    }

    func appendValue(_ value: Float) {
        result = result.multipliedReportingOverflow(by: constant).partialValue
            .addingReportingOverflow(Int(truncatingIfNeeded:value.bitPattern)).partialValue
    }
    
    func appendValue(_ value: Double) {
        result = result.multipliedReportingOverflow(by: constant).partialValue
            .addingReportingOverflow(Int(truncatingIfNeeded:value.bitPattern)).partialValue
    }
    
    func appendValue(_ value: Bool) {
        result = result.multipliedReportingOverflow(by: constant).partialValue
            .addingReportingOverflow(Int(truncatingIfNeeded:value ? 1 : 0)).partialValue
    }
    
    func appendValue<T: Hashable>(_ value: T) {
        result = result.multipliedReportingOverflow(by: constant).partialValue
            .addingReportingOverflow(value.hashValue).partialValue
    }
    
    func appendValue(_ value: AnyObject) {
        result = result.multipliedReportingOverflow(by: constant).partialValue
            .addingReportingOverflow(ObjectIdentifier(value).hashValue).partialValue
    }
    
    func appendValue<T: FixedWidthInteger>(_ array: [T]) {
        for value in array {
            self.appendValue(value)
        }
    }
    
    func appendValue(_ array: [Float]) {
        for value in array {
            self.appendValue(value)
        }
    }
    
    func appendValue(_ array: [Double]) {
        for value in array {
            self.appendValue(value)
        }
    }
    
    func appendValue(_ array: [Bool]) {
        for value in array {
            self.appendValue(value)
        }
    }
    
    func appendValue<T: Hashable>(_ array: [T]) {
        for value in array {
            self.appendValue(value)
        }
    }
    
    func appendValue(_ array: [AnyObject]) {
        for value in array {
            self.appendValue(value)
        }
    }
}
