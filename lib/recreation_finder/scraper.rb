class RecFinder::Scraper
  def self.get_page(index)
    Nokogiri::HTML(open(index))
  end
  def self.get_detail(url)
    Nokogiri::HTML(open(url))
  end
  def self.scrape_index(index)
    parks = []
    html_block = self.get_page(index).css("tr.maplink")
    html_block.each {|p|
      parks << {
      :url => p.css("a.linkurl")[0].attribute("href").value,
      :name => p.css("a.linkurl")[0].text
      }
    }
    parks
  end
  def self.scrape_detail(url)
    detail = self.get_detail(url)
    data = {
    :phone => detail.css("p.phone_numbers a")[0].text.gsub("Phone ",""),
    :address => detail.css("p.mainaddress").text.gsub("/\n/",",").split.join(" "),
    :description => detail.css("div.location--main_description").text.split.join(" ")
    }
    if detail.css("div.alert_banner").count == 1
      #puts detail.css("div.alert_banner").text
      data[:alert] = detail.css("div.alert_banner").text.split.join(" ")
    end
    data
  end
end

#test = Scraper.new
#puts test.scrape_index
#test.scrape_detail("http://www.thprd.org/facilities/nature/tualatin-hills-nature-center")