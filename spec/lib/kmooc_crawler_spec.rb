require 'spec_helper'
require 'kmooc_crawler' 

describe KmoocCrawler do
  describe "#crawl" do
    it "should crawl list of kmooc.kr" do
      # URL = "http://www.kmooc.kr/"
      URL = "./spec/fixtures/kmooc/list.html"

      crawler = KmoocCrawler.new
      list = crawler.crawl(URL)

      first_course = list.first
      expect(first_course[:title]).to eq("교육심리")
      expect(first_course[:link]).to eq("http://www.kmooc.kr/courses/course-v1:DKUK+KOCW.DKUK0001+201613157501/about")
      expect(first_course[:image]).to eq("http://www.kmooc.kr/asset-v1:DKUK+KOCW.DKUK0001+201613157501+type@asset+block@tit_img.jpg")
      expect(first_course[:organization]).to eq("단국대학교")
      expect(first_course[:code]).to eq("KOCW.DKUK0001")
      expect(first_course[:opened_at]).to eq(Date.parse("2016-05-02"))

      last_course = list.last
      expect(last_course[:title]).to eq("K-MOOC 시작하기")
      expect(last_course[:link]).to eq("http://www.kmooc.kr/courses/course-v1:KMOOC+DEMOk+2015_1/about")
      expect(last_course[:image]).to eq("http://www.kmooc.kr/asset-v1:KMOOC+DEMOk+2015_1+type@asset+block@demok1.jpg")
      expect(last_course[:organization]).to eq("KMOOC")
      expect(last_course[:code]).to eq("DEMOk")
      expect(last_course[:opened_at]).to eq(nil)
    end
  end

  describe "#parse_date" do
    it "should parse from raw text to date object" do
      crawler = KmoocCrawler.new

      expect_date = Date.parse("2016-05-02")
      actual_date = crawler.parse_date("개강일: 2016년5월02일")
      expect(actual_date).to eq(expect_date)

      expect_date = Date.parse("2016-08-13")
      actual_date = crawler.parse_date("개강일: 2016년08월13일")
      expect(actual_date).to eq(expect_date)

      expect_date = Date.parse("2016-12-05")
      actual_date = crawler.parse_date("개강일: 2016년12월05일")
      expect(actual_date).to eq(expect_date)
    end
  end
end