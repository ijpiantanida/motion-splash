class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    MotionSplash::Generator.generate_all
    true
  end
end