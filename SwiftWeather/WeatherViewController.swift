//
//  Created by Jake Lin on 8/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UIPageViewControllerDataSource {
  
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var iconLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet var forecastViews: [ForecastView]!
    
  //Adding in code to add a UIPageviewController
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = WeatherViewModel()
    viewModel?.startLocationService()
    
    self.pageTitles = NSArray(objects: "Explore", "Today Widget")
    self.pageImages = NSArray(objects: "page1","page2")
    
    self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
    
    self.pageViewController.dataSource = self
    var startVC = self.viewControllerAtIndex(0) as ContentViewController
    var viewControllers = NSArray(object: startVC)
    
    self.pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
    
    self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
    
    self.addChildViewController(self.pageViewController)
    self.view.addSubview(self.pageViewController.view)
    self.pageViewController.didMoveToParentViewController(self)
    
  }

    @IBAction func restartAction(sender: AnyObject) {
        
        var startVC = self.viewControllerAtIndex(0) as ContentViewController
        var viewControllers = NSArray(object: startVC)
        self.pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        
    }
    
    
    func viewControllerAtIndex(index: Int) -> ContentViewController
    {
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count))
        {
            return ContentViewController()
            
        }
        
        var vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        
        vc.imageFile = self.pageImages[index] as! String
        vc.titleText = self.pageTitles[index] as! String
        vc.pageIndex = index
        
        return vc
    }
    
    //MARK : Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound)
        
        {
            return nil
        }
        index--
        return self.viewControllerAtIndex(index)
        
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        index++
        
        if (index == self.pageTitles.count)
            
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
        
    }
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  // MARK: ViewModel
  var viewModel: WeatherViewModel? {
    didSet {
      viewModel?.location.observe {
        [unowned self] in
        self.locationLabel.text = $0
      }

      viewModel?.iconText.observe {
        [unowned self] in
        self.iconLabel.text = $0
      }

      viewModel?.temperature.observe {
        [unowned self] in
        self.temperatureLabel.text = $0
      }

      viewModel?.forecasts.observe {
        [unowned self] (let forecastViewModels) in
        if forecastViewModels.count >= 4 {
          for (index, forecastView) in self.forecastViews.enumerate() {
            forecastView.loadViewModel(forecastViewModels[index])
          }
        }
      }
    }
  }
}
