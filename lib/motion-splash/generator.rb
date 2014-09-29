class MotionSplash
  class Generator
    def self.generate_all
      config = Config.new
      controller_class = Kernel.const_get(config.controller_class)
      config.sizes.each do |size, scale|
        puts "Generating image for #{size}@#{scale}x"
        splash_controller = controller_class.alloc.initWithNibName(nil, bundle: nil)
        splash_controller.view.frame = [[0,0], size]
        puts "splash_controller.view.frame.height=#{splash_controller.view.frame.size.height}"

        UIGraphicsBeginImageContextWithOptions(splash_controller.view.bounds.size, true, scale)
        splash_controller.view.layer.renderInContext(UIGraphicsGetCurrentContext())
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        fileManager = NSFileManager.defaultManager
        image_data = UIImagePNGRepresentation(img)
        image_name = name_for(config, scale, size)
        image_name = "#{config.images_dir}/#{image_name}.png"
        puts "IMAGE=#{image_name}"
        fileManager.createFileAtPath(image_name , contents: image_data, attributes: nil)
      end
    end

    def self.name_for(config, scale, size)
      name = case scale.to_i
        when 2
          size_suffix = size.last == 480 ? "" : "-#{size.last.to_i}h"
          "#{config.image_name}#{size_suffix}@2x"
        when 3
          "#{config.image_name}-#{size.last.to_i}h@3x"
        else
          config.image_name
             end
      puts "name for #{scale} #{size} == #{name}"
      name
    end
  end
end