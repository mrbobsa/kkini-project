class WelcomeController < ApplicationController
  
  def index
      @course_detail = Course.all
  end
  
  def courses_intodb
      
      @arr_code=Array.new
      @arr_university=Array.new
      @arr_title=Array.new
      @arr_release_date=Array.new
      
      xml_doc = Nokogiri::XML(File.open("app/assets/xmls/courses_parse.xml"))
      
      @word_out_code = xml_doc.css("course//code").children.each do |save_code|
          @arr_code.push(save_code)
      end
      
      @word_out_university = xml_doc.css("course//university").children.each do |save_university|
          @arr_university.push(save_university)
      end
          
      @word_out_title = xml_doc.css("course//title").children.each do |save_title|
          @arr_title.push(save_title)
      end
          
      @word_out_release_date = xml_doc.css("course//release_date").children.each do |save_release_date|
          @arr_release_date.push(save_release_date)
      end
      
      @arr_all = @arr_code.zip(@arr_university, @arr_title, @arr_release_date)
      @arr_all.each do |arr_each|
      
              xml_intodb = Course.new
              xml_intodb.code = arr_each.at(0)
              xml_intodb.university = arr_each.at(1)
              xml_intodb.title = arr_each.at(2)
              xml_intodb.release_date = arr_each.at(3)
              xml_intodb.save
      end
        
      redirect_to '/welcome/index'
  end
  
  def about
  end
  
  def rank_tutor
  end
  
  def rank_tutor_in
  end
  
  def search
  end
  
  def search_in
  end
  
  # Just for test
  def kmooc
    url = "http://www.kmooc.kr/"

    crawler = KmoocCrawler.new
    list = crawler.crawl(url)
     
    render text: list
  end
  
  # Just for test2
  def kmooc_refill
    # Warning!!!
    Course.destroy_all
    
    url = "http://www.kmooc.kr/"

    crawler = KmoocCrawler.new
    list = crawler.crawl(url)
    
    list.each do |course|
      release_date = if course[:opened_at] == nil
        nil
      else
        course[:opened_at].strftime("%Y.%m.%d")
      end
      
      Course.create!({
        code: course[:code],
        university: course[:organization],
        title: course[:title],
        release_date: release_date,
        # image: course[:image],
        # link: course[:link],
      })
    end
    
    render text: "Success!"
    
  end
end
