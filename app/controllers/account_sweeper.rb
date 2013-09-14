class AccountSweeper < ActionController::Caching::Sweeper
  #TODO: caching
  #in the controller, specify:
  # caches_action :index
  # caches_page :index
  # cache_sweeper :account_sweeper

  observe Account

  def after_update(account)
    expire_cache_for(account)
  end

  private
  def expire_cache_for(account)
    expire_action :action => :edit
    #expire_fragment(:controller => , :action => , action_suffix => )
    #expire_page(:controller => , :action =>)
  end

end