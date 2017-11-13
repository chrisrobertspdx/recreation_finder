class RecreationFinder::Facility
  attr_accessor :name, :url, :phone, :address, :description, :alert
  @@all = []
  def initialize(rec_data)
    rec_data.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end
  def self.create_from_data(data)
    data.each{|d|
      self.new(d)
    }
  end
  def add_detail(detail_data)
    detail_data.each {|key, value| self.send(("#{key}="), value)}
    self.details_updated = true
  end
  def self.all
    @@all
  end

  def self.sayhello
    puts "hello"
  end
end