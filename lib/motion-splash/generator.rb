class MotionSplash
  class Generator
    def self.generate_all
      config = Config.new
      controller_class = Kernel.const_get(config.controller_class)
      enabled_sizes(config).each do |size, scale|
        puts "Generating image for #{size}@#{scale}x"
        splash_controller = controller_class.alloc.initWithNibName(nil, bundle: nil)
        splash_controller.view.frame = [[0, 0], size]

        image = create_image_for(scale, splash_controller)
        save_image(config, image, scale, size)
      end
    end

    def self.save_image(config, img, scale, size)
      fileManager = NSFileManager.defaultManager
      image_data = UIImagePNGRepresentation(img)
      image_name = name_for(config, scale, size)
      image_name = "#{config.images_dir}/#{image_name}.png"
      fileManager.createFileAtPath(image_name, contents: image_data, attributes: nil)
    end

    def self.create_image_for(scale, splash_controller)
      UIGraphicsBeginImageContextWithOptions(splash_controller.view.bounds.size, true, scale)
      splash_controller.view.layer.renderInContext(UIGraphicsGetCurrentContext())
      img = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      img
    end

    def self.enabled_sizes(config)
      config.sizes.reject do |size, scale|
        config.exclude_sizes.include?(size) ||
            config.exclude_scales.include?(scale)
      end
    end

    def self.name_for(config, scale, size)
      case scale.to_i
        when 2
          size_suffix = size.last == 480 ? "" : "-#{size.last.to_i}h"
          "#{config.image_name}#{size_suffix}@2x"
        when 3
          "#{config.image_name}-#{size.last.to_i}h@3x"
        else
          config.image_name
      end
    end
  end
end