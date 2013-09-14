class AccountsController < ApplicationController
  #TODO this controller here is just for a sample. Remove everything related to accounts when you are building some other app.
  #TODO: Important!
=begin
  check migrations
  check views
  check models
  check authorization_rules
=end
  before_filter :authenticate_user!, :except => [:index, :show]
  caches_action :edit, :layout => false
  cache_sweeper :account_sweeper
  #TODO these are two options how to use declarative_authorization in controller
  filter_resource_access
  #filter_access_to :all
  # GET /accounts
  # GET /accounts.json
  def index
    if user_signed_in?
      @accounts = real_accounts
      @v_accounts = virtual_accounts
      #logger.debug(@accounts.class)
      #@total = [100,200].sum
      #logger.debug(@total.to_s)
      @total = @accounts.sum(&:balance)
      @v_total = @v_accounts.sum(&:balance)
      #logger.debug(@accounts.respond_to?(:sum))
      #logger.debug(@accounts[0].respond_to?(:balance))
    end

    #@accounts = Account.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.json
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = current_user.accounts.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if current_user.accounts << @account
        format.html { redirect_to accounts_path, notice: 'Account was successfully created.' }
        format.json { render json: accounts_path, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = current_user.accounts.find(params[:id])
    respond_to do |format|
      #TODO: This is a simple captcha use in controller
      if simple_captcha_valid? && @account.update_attributes(params[:account])
        #TODO: mailer example
        AdminMailer.notification_email(current_user).deliver
        format.html { redirect_to accounts_path, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        unless simple_captcha_valid?
          flash.now[:captcha_error] = "simple_captcha.message.default"
          @account.errors[:captcha_error] = "invalid captcha entered"
        end
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = current_user.accounts.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end

  def distribute
    @v_accounts = virtual_accounts
    if params[:how] == "PR"
      top_up = Calc.distribute(@v_accounts, params[:amt], "PR")
    else
      top_up = Calc.distribute(@v_accounts, params[:amt], "EQ")
    end
    i = 0
    @v_accounts.each do |acct|
      acct.update_attribute(:balance, acct.balance + top_up[i])
      i += 1
    end

    respond_to do |format|
      format.html { redirect_to accounts_path, notice: 'Successfully distributed.' }
      format.json { head :no_content }
    end

  end

  def undistribute
    @accounts = real_accounts
    if params[:how] == "PR"
      top_up = Calc.distribute(@accounts, params[:amt], "PR")
    else
      top_up = Calc.distribute(@accounts, params[:amt], "EQ")
    end
    i = 0
    @accounts.each do |acct|
      acct.update_attribute(:balance, acct.balance + top_up[i])
      i += 1
    end

    respond_to do |format|
      format.html { redirect_to accounts_path, notice: 'Successfully undistributed.' }
      format.json { head :no_content }
    end

  end
end
