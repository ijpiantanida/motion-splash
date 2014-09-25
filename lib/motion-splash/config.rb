class MotionSplash
  class Config
    def initialize(app = nil)
      @app = app
      @properties_set = []
    end

    def info_plist
      @info_plist ||= begin
        NSBundle.mainBundle.infoDictionary
      rescue
        {}
      end
    end

    PROPERTIES = {
        controller_class: "SplashController",
        images_dir: File.join(Dir.pwd,"resources"),
        app_delegate_file: File.join(Dir.pwd, "app", "app_delegate.rb"),
        sizes: [[[320, 480], 1], [[320, 480], 2], [[320, 568], 2]],
        image_name: "Default"
    }

    prefix = "_splash_"
    PROPERTIES.keys.each do |property|
      define_method("#{property}=") do |value|
        @app.info_plist["#{prefix}#{property}"] = value
        info_plist["#{prefix}#{property}"] = value

        @properties_set << property
      end

      define_method(property) do
        info_plist["#{prefix}#{property}"]
      end
    end

    def finish
      (PROPERTIES.keys - @properties_set.dup).each do |property|
        default_value = PROPERTIES[property]
        default_value = default_value.call(@app) if default_value.is_a?(Proc)
        self.send("#{property}=", default_value)
        puts "SETTING #{property} to #{default_value}"
      end
    end
  end
end