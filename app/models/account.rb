class Account < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :account_type, :balance, :frozen_flag

  validates_numericality_of :balance
  validates_presence_of :name
  validates_length_of :name, :within => 1..7, :message => "should be there"

  after_validation :round_balance


  private

  def round_balance
    self.balance = ((self.balance*100).round).to_f/100.to_f
  end
end
