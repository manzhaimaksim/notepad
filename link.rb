class Link < Post
  def initialize
    super
    @url = ''
  end

  def read_from_console
    puts 'Адрес ссылки'
    @url = STDIN.gets.chomp

    puts 'Что это за ссылка?'
    @text = STDIN.gets.chomp
  end

  def to_strings
  end
end
