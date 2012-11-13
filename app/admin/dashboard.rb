ActiveAdmin.register_page "Dashboard" do
    ActiveAdmin::Dashboards.build do

        section "Guest Count" do
          div  do
              @my_hash = {}
              Reservation.minimum('startdate').to_date.upto(Reservation.maximum('enddate').to_date) do | date |
                @my_hash[date.strftime('%Y-%m-%d')] = 0
              end

              @reservation = Reservation.where('id > 1')  
              @reservation.each do |res|
                  @my_hash.each do |key, value |
                    if res.startdate.to_date <=  key.to_date and res.enddate.to_date > key.to_date
                      @my_hash[key] += 1
                    end
                end
              end    
              
              render "guest_count", { :guest_count => @my_hash }
          end
        end 

        section "Today's Arrivals and Occupants", :priority => 1 do
            table_for Reservation.where('startdate <= ? and enddate > ?', Time.now, Time.now) do
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
            end
            strong { link_to "Export to CSV", admin_reservations_path(:format => :csv) }
        end 

   
    end
end


