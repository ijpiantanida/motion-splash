class SplashController < UIViewController
  def loadView
    @layout = SplashLayout.new
    self.view = @layout.view
  end
end