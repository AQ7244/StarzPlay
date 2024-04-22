//
//  ShowInfoWorkerTests.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 22/04/2024.
//

@testable import StarzPlay
import XCTest

class ShowInfoWorkerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ShowInfoWorker!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupShowInfoWorker()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupShowInfoWorker()
    {
        sut = ShowInfoWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething()
    {
        // Given
        
        // When
        
        // Then
    }
    
    func testShowInfoWorker_WhenInitialised_HasGetShowInfoFunction() throws {

        // Arrange
        let request = ShowInfo.Show.Request(test: true)
        let sut = ShowInfoWorker()

        // Act
        var model: ShowBase?
        sut.getShowInfo(request: request) { result in
            
            switch result {
            case .success(let showInfo):
                model = showInfo
                
            case .failure(_):
                model = nil
            }
        }

        // Assert
        XCTAssertNotNil(model, "ShowInfo Model is nil")
    }
    
    func testShowInfoWorker_WhenInitialised_HasGetSeasonInfoFunction() throws {

        // Arrange
        let request = ShowInfo.Season.Request(test: true)
        let sut = ShowInfoWorker()

        // Act
        var model: SeasonModel?
        sut.getSeasonInfo(request: request) { [weak self] result in
            
            guard let self = self else {return}
            switch result {
            case .success(let seasonInfo):
                model = seasonInfo
                
            case .failure(_):
                model = nil
            }
        }

        // Assert
        XCTAssertNotNil(model, "SeasonInfo Model is nil")
    }
    
    func testShowInfoWorker_WhenInitialised_HasGetEpisodeInfoFunction() throws {

        // Arrange
        let request = ShowInfo.Episode.Request(test: true)
        let sut = ShowInfoWorker()

        // Act
        var model: EpisodeModel?
        sut.getEpisodeInfo(request: request) { [weak self] result in
            
            guard let self = self else {return}
            switch result {
            case .success(let episodeInfo):
                model = episodeInfo
                
            case .failure(_):
                model = nil
            }
        }

        // Assert
        XCTAssertNotNil(model, "EpisodeInfo Model is nil")
    }
}
