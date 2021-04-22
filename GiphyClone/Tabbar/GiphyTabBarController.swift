//
//  ViewController.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/20.
//

import UIKit

class GiphyTabBarController: UITabBarController {
    enum Tab: Int {
        case Home
        case Search
        case Mypage
    }
    lazy var tabBarItems: [Tab: UITabBarItem] = [
        .Home: UITabBarItem(
            title: "",
            image: UIImage(),
            selectedImage: UIImage()
        ),
        .Search: UITabBarItem(
            title: "",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage().setSFSymbols(systemName: "magnifyingglass", weight: .bold)
        ),
        .Mypage: UITabBarItem(
            title: "",
            image: UIImage(),
            selectedImage: UIImage()
        )
    ]
    let tempVC1 = UIViewController()
    let searchMain = SearchMainWireFrame.createSearchMainModule()
    let tempVC2 = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
}

extension GiphyTabBarController {
    func attribute() {
        self.tabBar.do {
            $0.tintColor = .white
            $0.barTintColor = .black
            $0.isTranslucent = false
            $0.unselectedItemTintColor = .systemGray2
            $0.standardAppearance.backgroundColor = .white
        }

        self.tempVC1.tabBarItem = tabBarItems[.Home]
        self.tempVC1.tabBarItem.isEnabled = false
        self.tempVC1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        self.searchMain.tabBarItem = tabBarItems[.Search]
        self.searchMain.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        self.tempVC2.tabBarItem = tabBarItems[.Mypage]
        self.tempVC2.tabBarItem.isEnabled = false
        self.tempVC2.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        
        let studyNVC = UINavigationController(rootViewController: self.tempVC1)
        studyNVC.navigationBar.tintColor = .white
        
        let myStudyNVC = UINavigationController(rootViewController: self.searchMain)
        myStudyNVC.navigationBar.tintColor = .white
        
        let setNVC = UINavigationController(rootViewController: self.tempVC2)
        setNVC.navigationBar.tintColor = .white
        
        self.viewControllers = [
            studyNVC,
            myStudyNVC,
            setNVC
        ]
        selectedIndex = 1
    }
}
