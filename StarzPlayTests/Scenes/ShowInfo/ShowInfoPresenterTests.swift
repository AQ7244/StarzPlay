//
//  ShowInfoPresenterTests.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 22/04/2024.
//

@testable import StarzPlay
import XCTest

class ShowInfoPresenterTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ShowInfoPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupShowInfoPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupShowInfoPresenter()
    {
        sut = ShowInfoPresenter()
    }
    
    // MARK: Test doubles
    
    class ShowInfoDisplayLogicSpy: ShowInfoDisplayLogic
    {
        var displayShowInfoCalled = false
        func displayShowInfo(viewModel: StarzPlay.ShowInfo.Show.ViewModel) {
            
            self.displayShowInfoCalled = true
        }
        
        var displaySeasonInfoCalled = false
        func displaySeasonInfo(viewModel: StarzPlay.ShowInfo.Season.ViewModel) {
            
            self.displaySeasonInfoCalled = true
        }
        
        var displayEpisodeInfoCalled = false
        func displayEpisodeInfo(viewModel: StarzPlay.ShowInfo.Episode.ViewModel) {
            
            self.displayEpisodeInfoCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShowInfoPresenter_WhenCalled_DisplayShowInfo_HasCalledFunctionSuccessfully()
    {
        // Given
        let spy = ShowInfoDisplayLogicSpy()
        sut.viewController = spy
        let response = ShowInfo.Show.Response()
        
        // When
        sut.presentShowInfo(response: response)
        
        // Then
        XCTAssertTrue(spy.displayShowInfoCalled, "presentShowInfo(response:) should ask the view controller to display the result")
    }
    
    func testShowInfoPresenter_WhenCalled_DisplaySeasonInfo_HasCalledFunctionSuccessfully()
    {
        // Given
        let spy = ShowInfoDisplayLogicSpy()
        sut.viewController = spy
        let response = ShowInfo.Season.Response()
        
        // When
        sut.presentSeasonInfo(response: response)
        
        // Then
        XCTAssertTrue(spy.displaySeasonInfoCalled, "presentSeasonInfo(response:) should ask the view controller to display the result")
    }
    
    func testShowInfoPresenter_WhenCalled_DisplayEpisodeInfo_HasCalledFunctionSuccessfully()
    {
        // Given
        let spy = ShowInfoDisplayLogicSpy()
        sut.viewController = spy
        let response = ShowInfo.Episode.Response()
        
        // When
        sut.presentEpisodeInfo(response: response)
        
        // Then
        XCTAssertTrue(spy.displayEpisodeInfoCalled, "presentEpisodeInfo(response:) should ask the view controller to display the result")
    }
}
