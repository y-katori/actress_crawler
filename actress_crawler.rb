#get information of av actress from DMM.com
require 'open-uri'
require 'nokogiri'

class ActressCrawler
  @@base_url = "http://www.dmm.co.jp/digital/videoa/-/actress/=/keyword="
  @@keywords = [
    "a", "i", "u", "e", "o",
    "ka", "ki", "ku", "ke", "ko",
    "sa", "si", "su", "se", "so",
    "ta", "ti", "tu", "te", "to",
    "na", "ni", "nu", "ne", "no",
    "ha", "hi", "hu", "he", "ho",
    "ma", "mi", "mu", "me", "mo",
    "ya", "yu", "yo",
    "ra", "ri", "ru", "re", "ro",
    "wa"]

  def self.get_all_actress
    all_actress = Array.new()

    @@keywords.each do |keyword|
      #get max of pages
      url = @@base_url + keyword + "/"
      doc = Nokogiri::HTML(open(url))
      text = doc.xpath("/html//div[@class='list-boxcaptside list-boxpagenation group']/p").text
      max_pages = text.match(/全(\d+)/)[1].to_i

      max_pages.times do |i|
        url_with_page = "#{url}page=#{i + 1}"
        doc = Nokogiri::HTML(open(url_with_page))
        actress_data = doc.xpath("/html//ul[@class='d-item act-box-100 group']/li/a/img")

        actress_data.each do |data|
          break if (data.attribute('alt').nil? || data.attribute('src').nil?)
          name_and_image_url = { "name" => data.attribute('alt').value,
                                 "image_url" => data.attribute('src').value }
          all_actress.push(name_and_image_url)
        end
      end
    end

    return all_actress
  end
end
