class CustomSplashViewController < UINavigationController
  attr_accessor :generator

  def viewDidLoad
    super
    UINavigationBar.appearance.barTintColor = UIColor.colorWithRed(0.28, green: 0.46, blue: 0.61, alpha: 1)

    controller = SplashController.alloc.init
    controller.generator = generator
    self.setViewControllers([controller], animated: false)
  end
end

class SplashController < UIViewController
  attr_accessor :generator

  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor
  end

  def viewDidAppear(animated)
    super
    @generator.take_image
  end
end