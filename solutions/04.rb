# Ugliest thing I've ever written

module UI
  class TextScreen
    def self.draw(&block)
      TextScreen.new.instance_eval(&block)
    end

    def initialize(separator: "", general_style: nil)
      @separator = separator
      @general_style = general_style
      @result = ""
    end

    def label(text:, border: "", style: nil)
      label = "#{border}#{text}#{border}#{@separator}"
      label = @general_style ? label.send(@general_style) : label
      label = style ? label.send(style) : label
      @result += label
    end

    def vertical(border: "", style: nil, &block)
      proxy = TextScreen.new separator: "\n", general_style: style
      @result += proxy.instance_eval(&block)
      @result = add_vertical_border(border)
      @result += @separator
    end

    def horizontal(border: "", style: nil, &block)
      proxy = TextScreen.new separator: "", general_style: style
      @result += border
      @result += proxy.instance_eval(&block)
      @result += border
      @result += @separator
    end

    def add_vertical_border(border)
      labels = @result.split("\n")
      length = (labels.max_by {|l| l.length}).length
      labels.map do |label|
        label.ljust(length).prepend(border).concat(border)
      end.join("\n")
    end
  end
end