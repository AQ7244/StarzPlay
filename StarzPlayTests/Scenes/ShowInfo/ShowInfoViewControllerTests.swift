//
//  ShowInfoViewControllerTests.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 22/04/2024.
//

@testable import StarzPlay
import XCTest

class ShowInfoViewControllerTests: XCTestCase
{
    // MARK: Subject under test
    
    var storyboard: UIStoryboard!
    var sut: ShowInfoViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupShowInfoViewController()
    }
    
    override func tearDown()
    {
        window = nil
        storyboard = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupShowInfoViewController()
    {
        let bundle = Bundle.main
        storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ShowInfoViewController") as? ShowInfoViewController
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class ShowInfoBusinessLogicSpy: ShowInfoBusinessLogic
    {
        var getShowInfoCalled = false
        func getShowInfo(request: ShowInfo.Show.Request) {
            
            self.getShowInfoCalled = true
        }
        
        var getSeasonInfoCalled = false
        func getSeasonInfo(request: ShowInfo.Season.Request) {
            
            self.getSeasonInfoCalled = true
        }
        
        var getEpisodeInfoCalled = false
        func getEpisodeInfo(request: ShowInfo.Episode.Request) {
            
            self.getEpisodeInfoCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShowInfoViewController_WhenCreated_HasUIViewsAndReferences() throws {
        // Arrange
        let imageViewShowBackdrop: UIImageView = try XCTUnwrap(sut.imageViewShowBackdrop, "imageViewShowBackdrop does not have a referencing outlet")
        let lblShowTitle: UILabel = try XCTUnwrap(sut.lblShowTitle, "lblShowTitle does not have a referencing outlet")
        let lblShowSummary: UILabel = try XCTUnwrap(sut.lblShowSummary, "lblShowSummary does not have a referencing outlet")
        let lblShowDetails: UILabel = try XCTUnwrap(sut.lblShowDetails, "lblShowDetails does not have a referencing outlet")
        
        // Act

        // Assert
        XCTAssertNotNil(imageViewShowBackdrop, "imageViewShowBackdrop does not have a referencing outlet")
        XCTAssertNotNil(lblShowTitle, "lblShowTitle does not have a referencing outlet")
        XCTAssertNotNil(lblShowSummary, "lblShowSummary does not have a referencing outlet")
        XCTAssertNotNil(lblShowDetails, "lblShowDetails does not have a referencing outlet")
    }
    
    func testShowInfoViewController_WhenViewIsLoaded_ShouldFetchShowInfo()
    {
        // Given
        let spy = ShowInfoBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.getShowInfoCalled, "viewDidLoad() should ask the interactor to fetch Show Info")
    }
    
    func testShowInfoViewController_WhenGetShowInfoFunctionIsCalled_ShowInfoIsFetched() 
    {
        // Given
        let viewModel = ShowInfo.Show.ViewModel()
        
        // When
        loadView()
        sut.displayShowInfo(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.lblShowTitle.text?.lowercased(), "billions", "displayShowInfo(viewModel:) should update the title text field")
    }
    
    func testShowInfoViewController_WhenViewIsLoaded_ShouldFetchSeasonInfo()
    {
        // Given
        let spy = ShowInfoBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.getSeasonInfoCalled, "viewDidLoad() should ask the interactor to fetch Season Info")
    }
    
    func testShowInfoViewController_WhenGetSeasonInfoFunctionIsCalled_SeasonInfoIsFetched()
    {
        // Given
        let viewModel = ShowInfo.Season.ViewModel()
        
        // When
        loadView()
        sut.displaySeasonInfo(viewModel: viewModel)
        
        // Then
        XCTAssertGreaterThan(sut.selectedSeasonInfo?.episodes?.count ?? 0, 0, "displaySeasonInfo(viewModel:) should update the selectedSeasonInfo object")
    }
    
    func testShowInfoViewController_WhenViewIsLoaded_ShouldFetchEpisodeInfo()
    {
        // Given
        let spy = ShowInfoBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.getEpisodeInfoCalled, "viewDidLoad() should ask the interactor to fetch Episode Info")
    }
    
    func testShowInfoViewController_WhenGetEpisodeInfoFunctionIsCalled_EpisodeInfoIsFetched()
    {
        // Given
        let viewModel = ShowInfo.Episode.ViewModel()
        
        // When
        loadView()
        sut.displayEpisodeInfo(viewModel: viewModel)
        
        // Then
        XCTAssertGreaterThan(sut.episodeInfo?.episodeNumber ?? 0, 0, "displayEpisodeInfo(viewModel:) should update the episodeInfo object")
    }
    
    func testShowInfoViewController_WhenCreated_HasTableViewAndReference() throws {
        // Arrange
        let tableView: UITableView = try XCTUnwrap(sut.tableView, "tableView does not have a referencing outlet")
        
        // Act

        // Assert
        XCTAssertNotNil(tableView, "tableView does not have a referencing outlet")
    }
    
    func testShowInfoViewController_WhenCreated_HasTableViewProtocolsRegistered() throws {
        // Arrange
        let tableView: UITableView = try XCTUnwrap(sut.tableView, "tableView does not have a referencing outlet")
        let tableViewDelegate = try XCTUnwrap(tableView.delegate, "ShowInfoViewController's tableView delegate is nil")
        let tableViewDataSource = try XCTUnwrap(tableView.dataSource, "ShowInfoViewController's tableView datasource is nil")
        
        // Act

        // Assert
        XCTAssertTrue(tableViewDelegate.isKind(of: ShowInfoViewController.self), "ShowInfoViewController is not injected to tableView as delegate")
        XCTAssertTrue(tableViewDataSource.isKind(of: ShowInfoViewController.self), "ShowInfoViewController is not injected to tableView as dataSource")
    }
    
    func testShowInfoViewController_WhenCreated_HasTableViewCellsRegistered() throws {
        // Arrange
        let tableView: UITableView = try XCTUnwrap(sut.tableView, "tableView does not have a referencing outlet")
        
        // Act
        let registeredCellClasses = tableView.value(forKey: "_cellClassDict") as? [String:Any]
        
        // Assert
        XCTAssertNotNil(registeredCellClasses?.contains(where: {($0.key == "EpisodeCell")}), "EpisodeCell is not registered with tableView")
    }
    
    func testShowInfoViewController_WhenCreated_HasCollectionViewAndReference() throws {
        // Arrange
        let collectionView: UICollectionView = try XCTUnwrap(sut.seasonCollectionView, "collectionView does not have a referencing outlet")
        
        // Act

        // Assert
        XCTAssertNotNil(collectionView, "collectionView does not have a referencing outlet")
    }
    
    func testShowInfoViewController_WhenCreated_HasCollectionViewProtocolsRegistered() throws {
        // Arrange
        let collectionView: UICollectionView = try XCTUnwrap(sut.seasonCollectionView, "collectionView does not have a referencing outlet")
        let collectionViewDelegate = try XCTUnwrap(collectionView.delegate, "ShowInfoViewController's collectionView delegate is nil")
        let collectionViewDataSource = try XCTUnwrap(collectionView.dataSource, "ShowInfoViewController's collectionView datasource is nil")
        
        // Act

        // Assert
        XCTAssertTrue(collectionViewDelegate.isKind(of: ShowInfoViewController.self), "ShowInfoViewController is not injected to collectionView as delegate")
        XCTAssertTrue(collectionViewDataSource.isKind(of: ShowInfoViewController.self), "ShowInfoViewController is not injected to collectionView as dataSource")
    }
    
    func testShowInfoViewController_WhenCreated_HasCollectionViewCellsRegistered() throws {
        // Arrange
        let collectionView: UICollectionView = try XCTUnwrap(sut.seasonCollectionView, "collectionView does not have a referencing outlet")
        
        // Act
        let registeredCellClasses = collectionView.value(forKey: "_cellClassDict") as? [String:Any]
        
        // Assert
        XCTAssertNotNil(registeredCellClasses?.contains(where: {($0.key == "SeasonCell")}), "SeasonCell is not registered with collectionView")
    }
}
