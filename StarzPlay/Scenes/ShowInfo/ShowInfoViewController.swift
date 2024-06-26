//
//  ShowInfoViewController.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//

import UIKit
import SDWebImage

protocol ShowInfoDisplayLogic: AnyObject
{
    func displayShowInfo(viewModel: ShowInfo.Show.ViewModel)
    func displaySeasonInfo(viewModel: ShowInfo.Season.ViewModel)
    func displayEpisodeInfo(viewModel: ShowInfo.Episode.ViewModel)
}

class ShowInfoViewController: UIViewController
{
    
    @IBOutlet weak var imageViewShowBackdrop: UIImageView!
    @IBOutlet weak var lblShowTitle: UILabel!
    @IBOutlet weak var lblShowSummary: UILabel!
    @IBOutlet weak var lblShowDetails: UILabel!
    @IBOutlet weak var seasonCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var fetchShowWithId: Int = Constants.BillionsShowId
    var showInfo: ShowBase?
    var selectedSeasonInfo: SeasonModel?
    var episodeInfo: EpisodeModel?
    var tappedSeasonIndex = 0
    var selectedSeasonIndex = 0
    
    var interactor: ShowInfoBusinessLogic?
    var router: (NSObjectProtocol & ShowInfoRoutingLogic & ShowInfoDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ShowInfoInteractor()
        let presenter = ShowInfoPresenter()
        let router = ShowInfoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupView()
        
        self.getShowInfo(showId: fetchShowWithId)
    }
    
    func setupView() {
        
        self.lblShowTitle.setupTextAppearance(textColor: UIConfigurations.SPLightTextColor, tintColor: UIConfigurations.SPLightTextColor, font: UIConfigurations.getUIFontMedium(fontSize: UIConfigurations.kFontSizeLarge))
        self.lblShowTitle.textAlignment = .left
        self.lblShowTitle.minimumScaleFactor = 0.7
        
        self.lblShowSummary.setupTextAppearance(textColor: UIConfigurations.FadeTextColor, tintColor: UIConfigurations.FadeTextColor, font: UIConfigurations.getUIFontMedium(fontSize: UIConfigurations.kFontSizeLarge))
        self.lblShowSummary.textAlignment = .left
        self.lblShowSummary.minimumScaleFactor = 0.7
        
        self.lblShowDetails.setupTextAppearance(textColor: UIConfigurations.SPLightTextColor, tintColor: UIConfigurations.SPLightTextColor, font: UIConfigurations.getUIFontRegular(fontSize: UIConfigurations.kFontSizeSmall))
        self.lblShowDetails.textAlignment = .left
        self.lblShowDetails.minimumScaleFactor = 0.7
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: String(describing: EpisodeCell.self), bundle: nil), forCellReuseIdentifier: String(describing: EpisodeCell.self))
    }
    
    // MARK: Helper Functions
    func updateSeasonListUIWithFetchedInfo(showInfo: ShowBase) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            self.seasonCollectionView.reloadData()
            
            guard let seasons = showInfo.seasons, let firstSeason = seasons.first, let seasonNumber = firstSeason.seasonNumber else { return }
            self.getSeasonInfo(showId: self.fetchShowWithId, seasonNumber: seasonNumber)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ShowInfoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = seasonCollectionView.frame.width / 3
        return CGSize(width: width, height: width)
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension ShowInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return showInfo?.numberOfSeasons ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = seasonCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SeasonCell.self), for: indexPath) as! SeasonCell
        
        cell.configureSeasonCell(seasons: showInfo?.seasons, row: indexPath.row, isSelected: indexPath.row == self.selectedSeasonIndex)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row < self.showInfo?.seasons?.count ?? 0 {
            
            if let selectedSeason = self.showInfo?.seasons?[indexPath.row], let seasonNumber = selectedSeason.seasonNumber {
                
                self.tappedSeasonIndex = indexPath.row
                self.getSeasonInfo(showId: fetchShowWithId, seasonNumber: seasonNumber)
            }
         }
    }
    
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension ShowInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedSeasonInfo?.episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EpisodeCell.self), for: indexPath) as! EpisodeCell
        
        let episode = selectedSeasonInfo?.episodes?[indexPath.row]
        cell.configureEpisodeCell(episode: episode)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: API Calls
extension ShowInfoViewController: ShowInfoDisplayLogic {
    
    // MARK: Show Info

    // MARK: Get
    func getShowInfo(showId: Int)
    {
        let request = ShowInfo.Show.Request(showId: "\(showId)")
        interactor?.getShowInfo(request: request)
    }
    
    // MARK: Display
    func displayShowInfo(viewModel: ShowInfo.Show.ViewModel)
    {
        if viewModel.success == true, let showInfo = viewModel.showInfo {
            
            self.showInfo = showInfo
            
            if let seasonName = showInfo.originalName {
                
                self.lblShowTitle.text = seasonName
            }
            
            var showSummary = ""
            if let firstAirDate = showInfo.firstAirDate {
                
                // We can use formatters too for this purpose if we need to deal with dates
                if let firstAirYear = firstAirDate.components(separatedBy: "-").first {
                    showSummary = showSummary + firstAirYear
                }
            }
            
            if let numberOfSeasons = showInfo.numberOfSeasons {
                
                showSummary = showSummary + " | \(numberOfSeasons) Seasons" + " | R" // Not sure what does this R mneans
            }
            
            self.lblShowSummary.text = showSummary
            
            if let seasonDetails = showInfo.overview {
                
                self.lblShowDetails.text = seasonDetails
            }
            
            self.updateSeasonListUIWithFetchedInfo(showInfo: showInfo)
            
            if let backdropPath = showInfo.backdropPath, let backdropImageURL = URL(string: "\(BuildConfiguration.shared.imageBaseURL)\(backdropPath)") {
                
                self.imageViewShowBackdrop.sd_setImage(with: backdropImageURL, placeholderImage: UIImage(named: "home_poster"), options: .progressiveLoad)
            }
            
        } else {
            
            self.showGenericAlert(title: Constants.Oops, description: Constants.UnableToFetchShowInfo, alertType: .Failure)
        }
    }
    
    // MARK: Seasson Info

    // MARK: Get
    func getSeasonInfo(showId: Int, seasonNumber: Int)
    {
        let request = ShowInfo.Season.Request(showId: "\(showId)", seasonNumber: "\(seasonNumber)")
        interactor?.getSeasonInfo(request: request)
    }
    
    // MARK: Display
    func displaySeasonInfo(viewModel: ShowInfo.Season.ViewModel)
    {
        if viewModel.success == true, let seasonInfo = viewModel.seasonInfo {
            
            self.selectedSeasonInfo = seasonInfo
            self.selectedSeasonIndex = self.tappedSeasonIndex
            
            DispatchQueue.main.async { [weak self] in
                
                self?.tableView.reloadData()
                self?.seasonCollectionView.reloadData()
            }
            
        } else {
            
            self.tappedSeasonIndex = self.selectedSeasonIndex
            self.showGenericAlert(title: Constants.Oops, description: Constants.UnableToFetchSeasonInfo, alertType: .Failure)
        }
    }
    
    // MARK: Episode Info

    // MARK: Get
    func getEpisodeInfo(showId: Int, seasonNumber: Int, episodeNumber: Int)
    {
        let request = ShowInfo.Episode.Request(showId: "\(showId)", seasonNumber: "\(seasonNumber)", episodeNumber: "\(episodeNumber)")
        interactor?.getEpisodeInfo(request: request)
    }
    
    // MARK: Display
    func displayEpisodeInfo(viewModel: ShowInfo.Episode.ViewModel)
    {
        if viewModel.success == true, let episodeInfo = viewModel.episodeInfo {
            
            println(object: episodeInfo)
            self.episodeInfo = episodeInfo
            
        } else {
            
            self.showGenericAlert(title: Constants.Oops, description: Constants.UnableToFetchEpisodeInfo, alertType: .Failure)
        }
    }
}
