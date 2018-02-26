require 'pry'
class HalfaBubbleout::Service
  attr_accessor :title, :url, :content, :contact


    def initialize (title = nil, url = nil)
      @title = title
      @url = url
    end

    def self.all
      @@all ||= scrape_services
    end

    def self.find(id)
      self.all[id-1]
    end

    def self.contact
      @contact ||= get_service.search(".social-nav p a").map{|sign| sign['href']}.last
    end

    def self.scrape_content
      doc = Nokogiri::HTML(open("http://www.halfabubbleout.com/business-consulting"))
      #doc.search("h3").text.strip()
    end

    private

    def self.scrape_services
       service_titles = get_service.search(".left-sidebar li a")
       service_titles.collect{|e| new(e.text.strip,"http://www.halfabubbleout.com#{e.attr("href")}")}
    end


      def self.get_service
        Nokogiri::HTML(open('http://www.halfabubbleout.com/our-services'))
      end

      binding.pry
end
