require_relative 'post'
require_relative 'memo'
require_relative 'link'
require_relative 'task'

require 'optparse'

options = {}

OptionParser.new do |opt|
  opt.banner = 'Usage: read.rb [options]'

  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end

  opt.on('--type POST_TYPE', 'какой тип постов показывать (по умолчанию любой)') { |type| options[:type] = type }
  opt.on('--id POST_ID', 'если задан id — показываем подробно только этот пост') { |id| options[:id] = id }
  opt.on('--limit NUMBER', 'сколько последних постов показать (по умолчанию все)') { |limit| options[:limit] = limit }

end.parse!

if options.key?(:id)
  result = Post.find_by_id(options[:id])
  if result.nil?
    puts "Такой id (#{options[:id]}) не найден в базе"
    exit
  else # показываем конкретный пост
    puts "Запись #{result.class.name}, id = #{options[:id]}"
    # выведем весь пост на экран и закроемся
    result.to_strings.each do |line|
      puts line
    end
  end
else
  result = Post.find_all(options[:limit], options[:type])
  print "| id\t| @type\t|  @created_at\t\t\t|  @text \t\t\t| @url\t\t| @due_date \t "

  result.each do |row|
    puts
    # puts '_'*80
    row.each do |element|
      print "|  #{element.to_s.delete("\\n\\r")[0..40]}\t"
    end
  end
end

puts
