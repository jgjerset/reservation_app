ActiveAdmin.register Reservation do

filter :startdate
filter :enddate
filter :first_name
filter :last_name
filter :id

scope :all, :default => true
scope :Occupants do |reservations| 
  Reservation.where('startdate <= ? and enddate > ?', Time.now, Time.now) 
end  

scope :Departures do |reservations| 
  Reservation.where('enddate >= ? and enddate <= ?', Time.zone.local(Time.now.year, Time.now.month, Time.now.day), Time.zone.local(Time.now.year, Time.now.month, Time.now.day)) 
end 

config.per_page = 10

    index do
      selectable_column
      column :id 
      column "Arrival date", :sortable => :startdate do |r|
        r.startdate.strftime('%m-%d-%Y')
      end
      column "Departure date", :sortable => :enddate do |r|
        r.enddate.strftime('%m-%d-%Y')
      end
      column :first_name
      column :last_name do |id|
        link_to id.last_name, admin_reservation_path(id)
      end        

      column :email
      column :phone
      #default_actions
    end

    form do |f|
      f.inputs "Details" do
        f.input :startdate, :as => :datepicker
        f.input :enddate, :as => :datepicker
        f.input :first_name
        f.input :last_name
        f.input :email
        f.input :phone
        f.buttons
      end
    end

    show :title => "Reservation View"  do
      panel "Reservations" do
          attributes_table do 
            row :startdate do |r|
              r.startdate.strftime('%m-%d-%Y')
            end  
            row :enddate do |r|
              r.enddate.strftime('%m-%d-%Y')
            end 
            row :last_name
            row :first_name
            row :email
            row :phone
          end
      end    
    end    

    csv do
      column :id
      column "Arrival date" do |r|
        r.startdate.strftime('%m-%d-%Y')
      end
      column "Departure date" do |r|
        r.enddate.strftime('%m-%d-%Y')
      end
      column :first_name
      column :last_name
      column :email
      column :phone
    end
end
