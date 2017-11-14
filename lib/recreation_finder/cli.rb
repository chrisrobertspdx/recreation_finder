class RecreationFinder::CLI
  #attr_accessor :facility
  BASE_URL = 'http://www.thprd.org'

  def run
    puts "Hello. I would like to help you find a place to recreate."
    make_recs
    #add_attributes_to_recs
    display_recs
  end
  
  def menu
  	puts "Select facility type:"
    puts "    Aquatic (A)"
    puts "    Historic (H)"
    puts "    Nature (N)"
    puts "    Recreation (R)"
    puts "    Senior (S)"

  end
  
  def make_recs
    RecreationFinder::Facility.create_from_data(RecreationFinder::Scraper.scrape_index(BASE_URL+"/facilities/directory/"))
  end
  
  def display_recs
    RecreationFinder::Facility.all.each_with_index{|r,index|
      puts "#{index+1}. #{r.name} #{r.type.upcase}"
    }
    print "Which recreation facility would you like more information about? "
    index = gets.strip.to_i
    detail = RecreationFinder::Facility.all[index-1]
    if detail.description == nil
      detail.add_detail(RecreationFinder::Scraper.scrape_detail(BASE_URL+detail.url))
    end
    puts ""
    puts detail.name.upcase
    if detail.alert != nil
      puts "*****" + detail.alert + "*****"
      puts
    end
    puts "-----------------------"
    puts detail.phone
    puts detail.address
    puts "-----------------------"
    
    puts detail.type.upcase
    puts detail.description
  end
end