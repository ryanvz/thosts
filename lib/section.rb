class Section
  attr_accessor :name, :enabled
  attr_reader :data
  alias_method :enabled?, :enabled
  alias_method :section?, :name

  def initialize(data)
    parse(data)
  end

  def header
    "# section #{name} #{status}\n" if section?
  end

  def enabled=(value)
    @enabled = ![nil, false, 'OFF'].include?(value)
  end

  def status
    enabled? ? 'ON' : 'OFF'
  end

  def toggle
    self.enabled = !enabled?
  end

  def to_s
    "#{header}#{data.join}"
  end

  def summary
    "#{name} = #{status}" if section?
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