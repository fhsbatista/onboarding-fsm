require 'date_time'

RSpec.describe DateTime do
  it "removes milliseconds of a time" do
    first_time = DateTime.no_usec(Time.now)
    second_time = DateTime.no_usec(Time.now)
    expect(first_time).to eq(second_time)
  end
end