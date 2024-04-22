//
//  ShowInfoInteractorTests.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 22/04/2024.
//

@testable import StarzPlay
import XCTest

class ShowInfoInteractorTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ShowInfoInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupShowInfoInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupShowInfoInteractor()
    {
        sut = ShowInfoInteractor()
    }
    
    // MARK: Test doubles
    
    class ShowInfoPresentationLogicSpy: ShowInfoPresentationLogic
    {
        var presentShowInfoCalled = false
        func presentShowInfo(response: ShowInfo.Show.Response)
        {
            presentShowInfoCalled = true
        }
        
        var presentSeasonInfoCalled = false
        func presentSeasonInfo(response: ShowInfo.Season.Response)
        {
            presentSeasonInfoCalled = true
        }
        
        var presentEpisodeInfoCalled = false
        func presentEpisodeInfo(response: ShowInfo.Episode.Response)
        {
            presentEpisodeInfoCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShowInfoInteractor_WhenShowInfoIsCalled_ShouldAskPresenterToFormatResults()
    {
        // Given
        let spy = ShowInfoPresentationLogicSpy()
        sut.presenter = spy
        let request = ShowInfo.Show.Request()
        
        // When
        sut.getShowInfo(request: request)
        
        // Then
        XCTAssertTrue(spy.presentShowInfoCalled, "getShowInfo(request:) should ask the presenter to format the result")
    }
    
    func testShowInfoInteractor_WhenSeasonInfoIsCalled_ShouldAskPresenterToFormatResults()
    {
        // Given
        let spy = ShowInfoPresentationLogicSpy()
        sut.presenter = spy
        let request = ShowInfo.Season.Request()
        
        // When
        sut.getSeasonInfo(request: request)
        
        // Then
        XCTAssertTrue(spy.presentSeasonInfoCalled, "getSeasonInfo(request:) should ask the presenter to format the result")
    }
    
    func testShowInfoInteractor_WhenEpisodeInfoIsCalled_ShouldAskPresenterToFormatResults()
    {
        // Given
        let spy = ShowInfoPresentationLogicSpy()
        sut.presenter = spy
        let request = ShowInfo.Episode.Request()
        
        // When
        sut.getEpisodeInfo(request: request)
        
        // Then
        XCTAssertTrue(spy.presentEpisodeInfoCalled, "getEpisodeInfo(request:) should ask the presenter to format the result")
    }
}
