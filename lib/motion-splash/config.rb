class MotionSplash
  class Config
    def initialize(app = nil)
      @app = app
      @properties_set = []
    end

    def info_plist
      @info_plist ||= begin
        if @app
          @app.info_plist
        else
          NSBundle.mainBundle.infoDictionary
        end
      rescue
        {}
      end
    end

    PROPERTIES = {
        controller_class: "SplashController",
        images_dir: File.join(Dir.pwd,"resources"),
        app_delegate_file: File.join(Dir.pwd, "app", "app_delegate.rb"),
        sizes: [[[320, 480], 1], [[320, 480], 2], [[320, 568], 2], [[375, 667], 2], [[414, 736], 3]],
        image_name: "Default",
        exclude_scales: [],
        exclude_sizes: []
    }

    def prefix
      "_splash_"
    end

    PROPERTIES.keys.each do |property|
      define_method("#{property}=") do |value|
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
        info_plist["#{prefix}#{property}"] = default_value
      end
    end
  end
end