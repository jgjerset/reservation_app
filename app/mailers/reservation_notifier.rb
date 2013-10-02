class ReservationNotifier < ActionMailer::Base
  default from: "Le Meridien Delfina <noreply@aceparking.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_notifier.newreservation.subject
  #
  def newreservation(reservation)
    @reservation = reservation

    mail to: reservation.email, subject: 'Parking Reservation from the Le Meridien'
  end
end
