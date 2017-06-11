# Motion-Splash

Create all your splash images from any UIViewController using whatever method you like to style it.

With Xcode 6 and iOS 8 came the ability to create your launch images from a XIB or storyboard file. This is a huge gain over manually creating every image in all the available resolutions.

But as a RubyMotion developer, I try to stay away as much as possible from the Xcode environment... I present you `Motion-Splash`

# Installation
```
gem install motion-splash

# or in Gemfile
gem 'motion-splash'
```

# How to use it
Require `motion-splash` in your Rakefile and add `MotionSplash.setup(app)` in your project setup block.

This will add the `rake splash` task to your project.
When running the task, the app will instantiate your `UIViewController` for every configured resolution/scale, present it over its own `UIWindow` and take a screenshot when you tell it to.

The only requirement is that your `UIViewController` instance responds to `#splash_generator=` and that you call `#take_snapshot` on the generator object whenever the controller's view is ready. Calling this method will save a snapshot to disk and continue with the next available resolution or exit if finished.

```ruby
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
```

**NOTE: the view controller's view frame is being manually adjusted after it has been created, so be sure to adjust the subviews' frames either by using AutoLayout or manually changing their frames in `viewWillLayoutSubviews`**

# Configuration
You can configure `MotionSplash` passing a block to `MotionSplash.setup`
```ruby
MotionSplash.setup(app) do |c|
  c.controller_class = "MyCustomSplashController"
  c.exclude_scales = [1, 3]
end
```

Avaiable options are:
* **controller_class**: Your splash controller class name (String). Defaults to "SplashController"
* **images_dir**: Absolute path to the directory where images should be saved. Defaults to the app's resources dir
* **image_name**: Launch image name. Defaults to "Default"
* **app_delegate_file**: Absolute path to the app's app_delegate file. Defaults to `app/app_delegate.rb`
* **sizes**: An array of all the needed sizes. Format of each entry must be [size, scale]. Defaults to `[[[320, 480], 1], [[320, 480], 2], [[320, 568], 2], [[375, 667], 2], [[414, 736], 3]]`
* **exclude_scales**: Array of scales that are not needed. Defaults to an empty array.
* **exclude_sizes**: Array of sizes that are not needed (ie [320, 480]). Defaults to an empty array.
* **custom_sizes**: Array with custom sizes. Format of each entry must be [size, scale]. Defaults to empty array.

# Samples
Check out the two sample apps:

* On the first one we create splash images using MotionKit and AutoLayout
* On the second one, we use an `UINavigationController` styled through the app's `UIAppearence`.

![Sample 1](https://raw.github.com/ijpiantanida/motion-splash/master/samples/sample-1/resources/Default.png)
![Sample 2](https://raw.github.com/ijpiantanida/motion-splash/master/samples/sample-2/resources/Default.png)

# How does it work?
When running the `rake splash` task, your `AppDelegate#application:didFinishLaunchingWithOptions:` will be overwritten with a custom implementation. 

For every enabled size, a `UIWindow` is created with the appropiate frame size and setted as keyAndVisible. After your view controller is presented, you should call `#take_snapshot` (usually within `#viewDidAppear`) and an image will be created drawing the `UIWindow` with `#drawViewHierarchyInRect`. Using `UIWindow` allows us to make crazy thinks like using `UIVisualEffectView`

