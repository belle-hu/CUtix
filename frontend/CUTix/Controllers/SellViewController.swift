//
//  SellViewController.swift
//  CUTix
//
//  Created by Maisie Yan on 11/28/23.
//

import Foundation
import UIKit
import SnapKit

class SellViewController: UIViewController {
    
    // MARK: - Properties (view)
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Properties (data)
    // private var event: [Event]
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    func configure() {
    }
    
    
    // MARK: - Set Up Views

    
}