class Reservation < ActiveRecord::Base



  attr_accessible :startdate_proper, :enddate_proper, :startdate, :enddate, :first_name, :last_name, :email, :phone 

  validates :startdate_proper, :enddate_proper, :startdate, :enddate, :first_name, :last_name,  presence: true

  validates :startdate, 
            :date => {:after_or_equal_to => Date.today, :message => 'must be on or after today'}

  validates :enddate, 
            :date => {:after => :startdate, :message => 'must be after start date' }

                      

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }                      

  validate :reservation_count

  RESERVATION_LIMIT = 50

  def reservation_count
      if startdate? && enddate?
        startdate.to_date.upto(enddate.to_date) do | date |
          if ((Reservation.where('DATE(startdate) <= ? and DATE(enddate) > ?', date, date).count) >= RESERVATION_LIMIT)
            errors[:base] << "Dear Guest,"
            errors[:base] << "  "
            errors[:base] << "Thank you for choosing the Sheraton Delfina for your travels. We are sorry but there is not any availability for our self parking at this time. We will make every attempt to reserve a space for you by the time of check in."
            errors[:base] << "  "
            errors[:base] << "Should you have any questions, please contact us at 310.399.9344 for further assistance."
            errors[:base] << "  "
            errors[:base] << "We look forward to welcoming you at the Sheraton Delfina hotel."
            errors[:base] << "  "
            errors[:base] << "Sincerely,"
            errors[:base] << "  "  
            errors[:base] << "Helene Grilliot"

            break
          end
        end  
      end
  end  

  def startdate_proper
    startdate.to_s(:proper) if startdate
  end

  def startdate_proper=(startdate_str)
    self.startdate = Date.strptime(startdate_str, "%m-%d-%Y") if startdate_str.present?
  end

  
  def enddate_proper
    enddate.to_s(:proper) if enddate
  end

  def enddate_proper=(enddate_str)
    self.enddate = Date.strptime(enddate_str, "%m-%d-%Y") if enddate_str.present?
  end

   obfuscate_id :spin => 64554664
end


