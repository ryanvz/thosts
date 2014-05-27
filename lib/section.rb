class Section
  attr_accessor :name, :enabled
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

  def enable
    self.enabled = true
  end

  def disable
    self.enabled = false
  end

  def toggle
    self.enabled = !enabled?
  end

  def data
    if section?
      @data.map do |row|
        row.sub(/^\s*#?\s*/, enabled? ? '' : '# ')
      end
    else
      @data
    end
  end

  def to_s
    "#{header}#{data.join}"
  end

  def summary
    "#{name} = #{status}" if section?
  end

  def stripped
    data.grep(/^\s*[\d]/)
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
