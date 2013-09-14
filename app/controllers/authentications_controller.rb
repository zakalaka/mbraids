class AuthenticationsController < ApplicationController
  #TODO: authentication
  #Remove this skipping after testing
  skip_before_filter :verify_authenticity_token, :only => [:create]

  # GET /authentications
  # GET /authentications.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authentications }
    end
  end

  # POST /authentications
  # POST /authentications.json
  def create
    auth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth[:provider], auth[:uid])
    if authentication
      flash[:notice] = t('devise.sessions.signed_in')
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
    #if user_signed_in?
      current_user.authentications.create!(:provider => auth[:provider], :uid => auth[:uid])
      flash[:notice] = t('devise.omniauth_callbacks.success')
      #redirect_to root_url
    #end
    else
      user = User.new
      user.apply_omniauth(auth)
      if user.save
        flash[:notice] = t('devise.sessions.signed_in')
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = auth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  # DELETE /authentications/1
  # DELETE /authentications/1.json
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy

    respond_to do |format|
      format.html { redirect_to authentications_url }
      format.json { head :no_content }
    end
  end
end
