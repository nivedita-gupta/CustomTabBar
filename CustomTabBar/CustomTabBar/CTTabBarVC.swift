//
//  CTTabBarVC.swift
//  CustomTabBar
//
//  Created by Nivedita Gupta on 31/03/17.
//  Copyright © 2017 Nivedita Gupta. All rights reserved.
//

import UIKit

class CTTabBarVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabButonsView: UIView!
    
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var reportsButton: UIButton!
    @IBOutlet weak var newsButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    var navOne: UINavigationController!
    var navTwo: UINavigationController!
    var navThree: UINavigationController!
    var navFour: UINavigationController!
    
    var viewOne: CTOneVC!
    var viewTwo: CTTwoVC!
    var viewThree: CTThreeVC!
    var viewFour: CTFourVC!
    
    var controllerArray = NSMutableArray()
    
    //MARK:- View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpOnLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Helper Methods
    
    func setUpOnLoad() {
        self.navigationController?.navigationBar.isHidden = true
        self.createTabBar()
        self.setSelectedIndex(0)
    }
    
    
    func createTabBar() {
        self.viewOne = self.storyboard?.instantiateViewController(withIdentifier: "CTOneVC") as! CTOneVC
        self.viewTwo = self.storyboard?.instantiateViewController(withIdentifier: "CTTwoVC") as! CTTwoVC
        self.viewThree = self.storyboard?.instantiateViewController(withIdentifier: "CTThreeVC") as! CTThreeVC
        self.viewFour = self.storyboard?.instantiateViewController(withIdentifier: "CTFourVC") as! CTFourVC
        
        self.navOne = UINavigationController(rootViewController: self.viewOne)
        self.navTwo = UINavigationController(rootViewController: self.viewTwo)
        self.navThree = UINavigationController(rootViewController: self.viewThree)
        self.navFour = UINavigationController(rootViewController: self.viewFour)
        
        controllerArray = [self.navOne,self.navTwo,self.navThree,self.navFour]
    }
   
    
    //MARK:- Memory Management Methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Button Actions
    
    @IBAction func commonButtonAction(_ sender: UIButton) {
        let tag = sender.tag%100
        self.setSelectedIndex(tag)
    }
    
    func setSelectedIndex(_ index: Int) {
        
        for i in 0 ..< 4
        {
            let button = self.view.viewWithTag(i+200) as! UIButton
            button.isSelected = (i == index)
            button.isUserInteractionEnabled = (i != index)
        }
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let controller = controllerArray[index] as! UINavigationController
        controller.view.frame = contentView.bounds
        contentView.addSubview(controller.view)
        self.addChildViewController(controller)
        controller.didMove(toParentViewController: self)
    }
    
}
