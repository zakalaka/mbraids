require 'shared'
class Appointment < ActiveRecord::Base
    include Shared
    has_many :line_items, :as => :quotable
    attr_accessible :apt_date, :apt_time, :completed_flag, :problem_flag, :description, :location, :booked_flag, :duration

    before_destroy :ensure_not_referenced
    private :ensure_not_referenced




end
