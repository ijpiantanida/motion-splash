class MotionSplash
  class Generator
    def self.generate_all
      config = Config.new
      controller_class = Kernel.const_get(config.controller_class)
      config.sizes.each do |size, scale|
        puts "Generating image for #{size}@#{scale}x"
        splash_controller = controller_class.alloc.initWithNibName(nil, bundle: nil)
        splash_controller.view.frame = [[0,0], size]
        splash_controller.view

        UIGraphicsBeginImageContextWithOptions(splash_controller.view.bounds.size, true, scale);
        splash_controller.view.layer.renderInContext(UIGraphicsGetCurrentContext())
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        fileManager = NSFileManager.defaultManager
        image_data = UIImagePNGRepresentation(img)
        image_name = "#{config.images_dir}/#{config.image_name}-#{size.last.to_i}-#{scale.to_i}.png"
        puts "IMAGE=#{image_name}"
        fileManager.createFileAtPath(image_name , contents: image_data, attributes: nil)
      end
    end
  end
end