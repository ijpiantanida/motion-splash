class SplashLayout < MK::Layout
  def layout
    root :splash do
      add UILabel, :title
      add UIView, :center_box do
        add UIImageView, :icon
      end
      add UIView, :bottom_box
      add UIVisualEffectView, :blurry_box
    end
  end

  def splash_style
    background_color UIColor.greenColor
  end

  def title_style
    text 'Awesome App'
    font UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    constraints do
      top.equals(30)
      center_x.equals(:superview)
    end
  end

  def center_box_style
    background_color UIColor.redColor
    constraints do
      center.equals(:superview)
      width.equals(:superview).times(0.9)
      height.equals(:superview, :width).times(0.9)
    end
  end

  def icon_style
    image UIImage.imageNamed("motionkit_logo")
    constraints do
      center.equals(:superview)
      size.is <= :superview
      height(:scale)
    end
  end

  def bottom_box_style
    background_color UIColor.blueColor
    constraints do
      center_x.equals(:superview)
      width.equals(:center_box)
      height.equals(40)
      bottom.equals(:superview).minus(15)
    end
  end

  def blurry_box_style
    effect UIBlurEffect.effectWithStyle(UIBlurEffectStyleLight)
    constraints do
      center_x.equals(:bottom_box)
      width.equals(:superview)
      height.equals(:bottom_box).plus(60)
      bottom.equals(:superview)
    end
  end
end