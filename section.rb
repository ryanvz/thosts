class Section
  attr_accessor :name, :enabled
  attr_reader :data
  alias_method :enabled?, :enabled

  def initialize(data)
    parse(data)
  end

  def header
    "# section #{name} #{enabled? ? 'ON' : 'OFF'}\n" if @name
  end

  def enabled=(value)
    @enabled = ![nil, false, 'OFF'].include?(value)
  end

  def toggle
    self.enabled = !enabled?
  end

  def to_s
    "#{header}#{data.join}"
  end

  private

  def parse(data)
    match = data.first.match(/^\s*#\s*section\s+(?<name>.*?\S)\s*(?<status>ON|OFF|)?\s*$/)
    if match
      @name, self.enabled = match.captures
      @data = data.drop(1)
    else
      @data = data
      self.enabled = true
    end
  end
end
