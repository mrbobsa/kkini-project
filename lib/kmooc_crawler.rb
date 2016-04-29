require 'open-uri'
require 'nokogiri'

class KmoocCrawler
  BASE_URL = "http://www.kmooc.kr"

  def crawl(url)
    doc = Nokogiri::HTML(open(url))

    list = []

    courses_listing_item = doc.css("ul.courses-listing li.courses-listing-item")

    courses_listing_item.map do |li_element|
      link_element = li_element.at_css('a')

      title = link_element['title']
      title.gsub!(" 자세히 알아보기", '')

      link = link_element['href']

      # 첫 번째 img 태그에 타이틀 사진이 담겨있음
      image_element = li_element.at_css('img')
      image = image_element['src']

      organization_element = li_element.at_css('span.course-organization')
      organization = organization_element.text

      code_element = li_element.at_css('span.course-code')
      code = code_element.text

      date_elements = li_element.css('.course-date')

      # 두 번째 element에 예정일이 담겨있음
      opened_at_text = date_elements[1].text

      {
        title: title,
        link: BASE_URL + link,
        image: BASE_URL + image,
        organization: organization,
        code: code,
        opened_at: parse_date(opened_at_text),
      }
    end
  end

  def parse_date(raw_text)
    if raw_text == "개강일: 자율 진도"
      return nil
    end

    raw_text.gsub!("개강일: ")

    first_split = raw_text.split("년")
    year = first_split[0]

    if first_split[1].nil?
      puts raw_text
    end

    second_split = first_split[1].split("월")
    month = second_split[0]
    day = second_split[1]

    Date.parse("#{year}-#{month}-#{day}")
  end
end