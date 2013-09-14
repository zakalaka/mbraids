require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp')
  provider :developer unless Rails.env.production?
end