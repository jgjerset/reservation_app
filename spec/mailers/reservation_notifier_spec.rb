require "spec_helper"

describe ReservationNotifier do
  describe "newreservation" do
    let(:mail) { ReservationNotifier.newreservation }

    it "renders the headers" do
      mail.subject.should eq("Newreservation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
