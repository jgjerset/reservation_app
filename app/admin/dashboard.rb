ActiveAdmin.register_page "Dashboard" do
    ActiveAdmin::Dashboards.build do
        section "Todays Arrivals" do
            table_for Reservation.where('startdate >= ? and startdate <= ?', Time.now.beginning_of_day, Time.now.end_of_day) do
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
        end 
    end
end


