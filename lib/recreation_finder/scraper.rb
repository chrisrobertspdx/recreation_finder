class RecreationFinder::Scraper
  def self.get_page(index)
    Nokogiri::HTML(open(index))
  end
  def self.get_detail(url)
    Nokogiri::HTML(open(url))
  end

  def self.scrape_index(index)
    facilities = []
    html_block = self.get_page(index).css("tr.maplink")
    html_block.each {|f|
      facilities << {
      :url => f.css("a.linkurl")[0].attribute("href").value,
      :type => f.css("a.linkurl")[0].attribute("href").value.split("/")[2],
      :name => f.css("a.linkurl")[0].text
      }
    }
    facilities
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
  def self.scrape_detail_xpath(url)
    detail = self.get_detail(url)
    data = {
      :phone => detail.xpath("/html/body/div[3]/div[2]/div[1]/div[2]").text.split.join(" ")
    }
    
  end
end

#test = Scraper.new
#puts test.scrape_index
#test.scrape_detail("http://www.thprd.org/facilities/nature/tualatin-hills-nature-center")