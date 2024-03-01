class DateTime
  def self.no_usec(time)
    Time.at(time.to_i)
  end
end