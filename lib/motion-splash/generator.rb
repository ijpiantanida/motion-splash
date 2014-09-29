class MotionSplash
  class Generator
    def self.generate_all
      self.new.start
    end
    
    def initialize
      @config = Config.new
      @current_index = 0
    end
    
    def start
      setup_next_size
    end

    def setup_next_size
      exit if @current_index >= enabled_sizes.size
      size, scale = enabled_sizes[@current_index]
      setup_for(size, scale)
    end

    def setup_for(size, scale)
      puts "Generating image for #{size}@#{scale}x"
      controller_class = Kernel.const_get(@config.controller_class)
      splash_controller = controller_class.alloc.initWithNibName(nil, bundle: nil)
      splash_controller.generator = self

      @window = UIWindow.alloc.initWithFrame([[0,0], size])
      @window.rootViewController = splash_controller
      @window.makeKeyAndVisible
      splash_controller.view.frame = [[0, 0], size]
    end

    def take_image
      size, scale = enabled_sizes[@current_index]
      image = create_image_for(scale, @window)
      save_image(image, scale, size)
      @current_index += 1
      setup_next_size
    end

    def save_image(img, scale, size)
      fileManager = NSFileManager.defaultManager
      image_data = UIImagePNGRepresentation(img)
      image_name = name_for(scale, size)
      image_name = "#{@config.images_dir}/#{image_name}.png"
      fileManager.createFileAtPath(image_name, contents: image_data, attributes: nil)
    end

    def create_image_for(scale, view)
      UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, scale)
      view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
      img = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      img
    end

    def enabled_sizes
      @enabled_sizes ||= @config.sizes.reject do |size, scale|
        @config.exclude_sizes.include?(size) ||
            @config.exclude_scales.include?(scale)
      end + @config.custom_sizes
    end

    def name_for(scale, size)
      case scale.to_i
        when 2
          size_suffix = size.last == 480 ? "" : "-#{size.last.to_i}h"
          "#{@config.image_name}#{size_suffix}@2x"
        when 3
          "#{@config.image_name}-#{size.last.to_i}h@3x"
        else
          @config.image_name
      end
    end
  end
end