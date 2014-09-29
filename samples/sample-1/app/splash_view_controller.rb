class SplashController < UIViewController
  attr_writer :splash_generator

  def loadView
    @layout = SplashLayout.new
    self.view = @layout.view
  end

  def viewDidAppear(animated)
    super
    @splash_generator.take_snapshot
  end
end