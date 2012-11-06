ActiveAdmin.register Reservation do

filter :startdate
filter :enddate
filter :first_name
filter :last_name
filter :id

batch_action :destroy, :confirm => "Permanently delete all selected reservations?" do |selection|
 logger.debug "Jon #{selection}"
 sql = "delete from reservations where id in (#{selection.to_param.gsub(/\//,",")})"
 ActiveRecord::Base.connection.execute(sql)
 #Reservation.find(selection).each { |p| destroy }
 redirect_to collection_path
end


scope :all, :default => true
scope :Occupants do |reservations| 
  Reservation.where('startdate <= ? and enddate > ?', Time.now, Time.now) 
end  

scope :Departures do |reservations| 
  Reservation.where('DATE(enddate) = ?', Date.today) 
end 

config.per_page = 50

    index do
      selectable_column
      column :id.to_param 
      column "Arrival date", :sortable => :startdate do |r|
        r.startdate.strftime('%m-%d-%Y')
      end
      column "Departure date", :sortable => :enddate do |r|
        r.enddate.strftime('%m-%d-%Y')
      end
      column :first_name
      column :last_name, :sortable => :last_name do |id|
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
