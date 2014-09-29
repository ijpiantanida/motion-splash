class CustomSplashViewController < UINavigationController
  attr_writer :splash_generator

  def viewDidLoad
    super
    UINavigationBar.appearance.barTintColor = UIColor.colorWithRed(0.28, green: 0.46, blue: 0.61, alpha: 1)

    controller = SplashController.alloc.init
    controller.splash_generator = @splash_generator
    self.setViewControllers([controller], animated: false)
  end
end

class SplashController < UIViewController
  attr_accessor :splash_generator

  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor
  end

  def viewDidAppear(animated)
    super
    @splash_generator.take_snapshot
  end
end