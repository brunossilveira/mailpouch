class TimeInterval
  def self.list
    (0..23).map do |t|
      ['00', '15', '30', '45'].map do |m|
        "#{t}:#{m}"
      end
    end.flatten
  end
end
