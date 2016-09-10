require './actress_crawler.rb'

all_actress = ActressCrawler.get_all_actress
file = File.open('./hoge.txt', 'a')

all_actress.each do |actress|
  file.puts "name->#{actress["name"]}"
end

file.close
