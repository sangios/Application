//
//  ApplicationTests.swift
//  ApplicationTests
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import XCTest
@testable import Application

class ApplicationTests: XCTestCase {
    
    override func setUp() {

    }

    override func tearDown() {

    }

    func testOneWord() {
        let inputKeyword = "iPhone"
        let finalKeyword = "iPhone"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testTwoWords() {
        let inputKeyword = "iPhone iPhone"
        let finalKeyword = "iPhone\niPhone"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testThreeWords() {
        let inputKeyword = "iPhone iPhone iPhone"
        let finalKeyword = "iPhone\niPhone iPhone"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testThreeWords2() {
        let inputKeyword = "iPhone iPhone X"
        let finalKeyword = "iPhone\niPhone X"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testThreeWords3() {
        let inputKeyword = "iPhone XS Max2"
        let finalKeyword = "iPhone\nXS Max2"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testFourWords() {
        let inputKeyword = "iPhone iPhone X M"
        let finalKeyword = "iPhone\niPhone X M"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testFourWords2() {
        let inputKeyword = "iPhoneiPhone X M"
        let finalKeyword = "iPhoneiPhone\nX M"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testFourWords3() {
        let inputKeyword = "iPhone iPhone iPhone iPhone"
        let finalKeyword = "iPhone iPhone\niPhone iPhone"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testFourWords4() {
        let inputKeyword = "iPhone iPhoneXS iPhone iPhone"
        let finalKeyword = "iPhone iPhoneXS\niPhone iPhone"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testFourWords5() {
        let inputKeyword = "iPhone iPhone iPhoneXS iPhone"
        let finalKeyword = "iPhone iPhone\niPhoneXS iPhone"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }
    
    func testFourWords6() {
        let inputKeyword = "iPhoneXXXXXXXXXX iPhone iPhone iPhone"
        let finalKeyword = "iPhoneXXXXXXXXXX\niPhone iPhone iPhone"
        
        let keyword = Keyword(text: inputKeyword, icon: nil)
        let viewModel = HotKeywordViewModel(keyword: keyword)
        XCTAssert(finalKeyword == viewModel.text, "Result: \(viewModel.text) - Expected: \(finalKeyword)")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            
        }
    }
}
