class ReservationNotifier < ActionMailer::Base
  default from: "Sheraton Delfina <jon@gjerset.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_notifier.newreservation.subject
  #
  def newreservation(reservation)
    @reservation = reservation

    mail to: reservation.email, subject: 'Parking Reservation from the Sheraton'
  end
end
