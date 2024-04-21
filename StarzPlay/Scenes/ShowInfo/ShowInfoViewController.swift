//
//  ShowInfoViewController.swift
//  StarzPlay
//
//  Created by Aqeel Ahmed on 21/04/2024.
//  Copyright (c) 2024 Aqeel Ahmed. All rights reserved.
//

import UIKit

protocol ShowInfoDisplayLogic: AnyObject
{
    func displaySomething(viewModel: ShowInfo.Something.ViewModel)
}

class ShowInfoViewController: UIViewController
{
    
    @IBOutlet weak var seasonCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var tvShowBaseInfo: ShowBase?
    var selecteSeasonBase: SeasonModel?
    
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
        doSomething()
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
        
        return tvShowBaseInfo?.numberOfSeasons ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = seasonCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SeasonCell.self), for: indexPath) as! SeasonCell
        
        cell.configureSeasonCell(seasons: tvShowBaseInfo?.seasons, row: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.tvShowBaseInfo?.seasons?.count ?? 0 > 0 {
            if let season = self.tvShowBaseInfo?.seasons?[indexPath.row] {
//                self.fetchSeasonInfo(seasonNumber: season.seasonNumber ?? 0)
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
        
        return selecteSeasonBase?.episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EpisodeCell.self), for: indexPath) as! EpisodeCell
        
        let episode = selecteSeasonBase?.episodes?[indexPath.row]
        cell.configureEpisodeCell(episode: episode)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: API Calls
extension ShowInfoViewController: ShowInfoDisplayLogic {
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = ShowInfo.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ShowInfo.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}
