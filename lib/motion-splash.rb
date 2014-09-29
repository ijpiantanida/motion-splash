require 'motion-splash/config.rb'

class MotionSplash
  def self.generate!
    @should_generate = true
  end

  def self.should_generate?
    @should_generate
  end

  def self.setup(app)
    config = Config.new(app)
    yield(config) if block_given?
    config.finish

    if MotionSplash.should_generate?
      app.files << File.join(File.dirname(__FILE__), 'motion-splash/generator.rb')
      app.files << File.join(File.dirname(__FILE__), 'motion-splash/config.rb')
      splash_delegate = File.join(File.dirname(__FILE__), 'motion-splash/splash_app_delegate.rb')
      app.files << splash_delegate

      system("touch \"#{splash_delegate}\"")
    else
      system("touch \"#{config.app_delegate_file}\"")
    end
  end
end

desc "Creates splash images"
task 'splash' do
  MotionSplash.generate!
  Rake::Task["simulator"].invoke
end