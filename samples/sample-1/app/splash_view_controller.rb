class SplashController < UIViewController
  attr_accessor :generator

  def loadView
    @layout = SplashLayout.new
    self.view = @layout.view
  end

  def viewDidAppear(animated)
    super
    @generator.take_image
  end
end