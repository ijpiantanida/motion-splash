class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    MotionSplash::Generator.generate_snapshots
    true
  end
end