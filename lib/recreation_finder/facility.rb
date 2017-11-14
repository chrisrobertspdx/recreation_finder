class RecreationFinder::Facility
  attr_accessor :name, :url, :phone, :address, :description, :alert, :type
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
    #self.details_updated = true
  end
  def self.all
    @@all
  end

  def self.display_list(category=nil)
    self.all.each_with_index{|r,index|
      puts "#{index+1}. #{r.name} #{r.type.upcase}"
    }
  end

  def self.get_facility_by_name(name)
    @@all.find {|f| f.name == name}
  end

  def self.sayhello
    puts "hello"
  end
end