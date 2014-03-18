require_relative('rpn_calculator')

class Feeder
  def initialize(file='rpn_data.txt')
    @lines = []
    load_file(file)
    execute
  end

  def load_file file_name
    have_file = false
    begin
      File.open(file_name) do |file|
        file.each_line do |l|
          @lines << l.chomp
        end
        have_file = true
      end
    rescue
      puts "File not found: "
      have_file = false
    end
    return have_file
  end

  def execute
    @lines.each do |l|
      puts("#{l} evaluates to : #{RPNCalculator.evaluate(RPNCalculator.parse(l))}")
    end
  end
end
if ARGV[0] && ARGV[0].length > 0
  f = Feeder.new(ARGV[0])
else
  f = Feeder.new
end