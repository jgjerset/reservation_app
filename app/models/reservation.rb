class Reservation < ActiveRecord::Base
  attr_accessible :email, :enddate, :first_name, :last_name, :phone, :startdate

  validates :startdate, :enddate, :first_name, :last_name,  presence: true

  validates :startdate, 
            :date => {:after_or_equal_to => Date.today, :message => 'must be after today'},
                      :on =>:create

  validates :enddate, 
            :date => {:after_or_equal_to  => :startdate, :message => 'must be after start date' },
                      :on => :create

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }                      

  validate :reservation_count

  RESERVATION_LIMIT = 5

  def reservation_count
      if startdate? && enddate?
        startdate.to_date.upto(enddate.to_date) do | date |
          if ((Reservation.where('DATE(startdate) <= ? and DATE(enddate) >= ?', date, date).count) > RESERVATION_LIMIT)
            errors[:base] << "Sorry, no reservations available during that period." 
            break
          end
      end  
  end
     
     


  end  
  


end


