require_relative 'post'
require_relative 'link'
require_relative 'task'
require_relative 'memo'

puts 'Привет, я твой блокнот версия 2! Записываю новые записи в базу SQLite3'
puts 'Что вы хотите записать в блокнот?'

choices = Post.post_types.keys

choice = -1

until choice >= 0 && choice < choices.size
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end

  choice = STDIN.gets.chomp.to_i
end

entry = Post.create(choices[choice])
entry.read_from_console
rowid = entry.save_to_db

puts "Ваша запись сохранена в базе, id = #{rowid}"
