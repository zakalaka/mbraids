class ApplicationController < ActionController::Base
  #layout("carousel", only: "index")
  #TODO: captcha
  include SimpleCaptcha::ControllerHelpers
  protect_from_forgery

  before_filter {|c| Authorization.current_user = c.current_user}
  #TODO: i18n
  before_filter :set_locale
  #this is for internationalization
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  def index
    #@test_var = test_display
    @c_user = current_user
    #logger.debug(@c_user.inspect)
    render layout: "carousel"
  end

  protected
  def permission_denied
    flash[:error] = t('declarative_authorization.permission_denied')
    redirect_to root_url
  end

  private
  #this is for internationalization
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_quote_box(_display=false)
    begin
      QuoteBox.find(session[:quote_box_id])
    rescue ActiveRecord::RecordNotFound
      if _display
        return nil
      else
        quote_box = QuoteBox.create
        session[:quote_box_id] = quote_box.id
        return quote_box
      end
    end
  end

  def get_random_suffix
    (0...5).map{ ('a'..'z').to_a[rand(26)] }.join
  end

  def set_image_filename(orig_filename)
    orig_filename.split('.')[0] + "_#{get_random_suffix}." + orig_filename.split('.')[1]
  end
end
