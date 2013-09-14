SimpleCaptcha.setup do |sc|
  #TODO: change this path when deploying
  sc.image_magick_path = 'C:/ImageMagick/ImageMagick-6.8.1-Q16' # you can check this from console by running: which convert
    # default: 100x28
    sc.image_size = '120x28'

    # default: 5
    sc.length = 6

    # default: simply_blue
    # possible values:
    # 'embosed_silver',
    # 'simply_red',
    # 'simply_green',
    # 'simply_blue',
    # 'distorted_black',
    # 'all_black',
    # 'charcoal_grey',
    # 'almost_invisible'
    # 'random'
    sc.image_style = 'simply_blue'

    # default: low
    # possible values: 'low', 'medium', 'high', 'random'
    sc.distortion = 'medium'
end