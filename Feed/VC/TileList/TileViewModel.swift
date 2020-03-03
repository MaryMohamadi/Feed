//
//  TileViewModel.swift
//  Feed
//
//  Created by Maryam Alimohammadi on 2/16/20.
//  Copyright © 2020 Maryam Alimohammadi. All rights reserved.
//

import Foundation

class TileViewMode {
    
    var tilesArray: [TileModel] = []
    var error : String!

    func fetchData(completion: @escaping () -> Void)
    
    {
        let x = CoreDataManager.sharedManager.fetchAll()
        print("????????????????? ==== \(x.count)")
   
        APIService.shared.request() { [weak self] (result: Result<TileResponseModel, Error>) in
            switch result{
            case .success(let tilesArray):
                self?.tilesArray = tilesArray.tiles.sorted(by: { $0.getScore() < $1.getScore() })
            case . failure(let error):
                self?.error = error.localizedDescription
            }
            
            completion()
        }
    }
    
    public func getCellType(index: Int) -> TileTypes?{
        let model = tilesArray[index]
        guard let name = model.name else {
            return nil
        }
        switch name {
        case TileTypes.image.rawValue :
            return .image
        case TileTypes.video.rawValue :
            return .video
        case TileTypes.website.rawValue :
            return .website
        case TileTypes.shopping_list.rawValue :
            return .shopping_list
        default:
            return nil
        }
    }
    
    public func getTileData(index: Int) -> String?{
        let model = tilesArray[index]
        return model.data
    }
    
    public func getTileHeadLine(index: Int) -> String?{
        let model = tilesArray[index]
        return model.headline
    }
    
}


