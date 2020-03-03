//
//  ViewController.swift
//  Feed
//
//  Created by Maryam Alimohammadi on 2/14/20.
//  Copyright © 2020 Maryam Alimohammadi. All rights reserved.
//

import UIKit
import AVKit

class TileListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    static let imageVCID = "TileImageViewController"
    static let webVCID = "WebViewViewController"
    
    private var dataSource: TableViewDataSource<TileModel, TileTableViewCell>!
    private var viewModel = TileViewMode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        getData()
        
    }
    
    private func configView(){
        title = "Tiles"
        tableView.backgroundColor = #colorLiteral(red: 0.8931308389, green: 0.920907259, blue: 0.9666106105, alpha: 1)
        tableView.register(UINib(nibName: TileTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TileTableViewCell.reuseIdentifier)
    }
    
    private func getData(){
        viewModel.fetchData { [weak self] in
            self?.dataSource = TableViewDataSource.make(tiles: (self?.viewModel.tilesArray) ?? [])
            self?.tableView.dataSource = self?.dataSource
            self?.tableView.reloadData()
        }
    }
    
    
    
}


extension TileListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = viewModel.getCellType(index: indexPath.row) else{
            return
        }
        
        guard let data = viewModel.getTileData(index: indexPath.row) else{
            return
        }
        
        let headline = viewModel.getTileHeadLine(index: indexPath.row)
        
        switch type {
        case .image:
            showImage(with: data, headline: headline)
        case .video:
            showVideo(with: data)
        case .website:
            showWebView(with: data, headline: headline)
        default:
            break
        }
    }
    
    //MARK: - Load Image view
    private func showImage(with url: String, headline: String?){
        let vc = storyboard?.instantiateViewController(withIdentifier: TileListViewController.imageVCID) as! TileImageViewController
        vc.imageSource = url
        vc.titleName = headline
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Load Video view
    private func showVideo(with url: String){
        guard let url = URL(string: url) else{
            return
        }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    
    //MARK: - Load Webview
    private func showWebView(with url: String, headline: String?){
        let vc = storyboard?.instantiateViewController(withIdentifier: TileListViewController.webVCID) as! WebViewViewController
        vc.videoSource = url
        vc.titleName = headline
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

