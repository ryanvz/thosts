require_relative 'section'

class HostsFile
  DEFAULT_PATH = '/etc/hosts'
  attr_reader :sections, :path

  def initialize(path = DEFAULT_PATH)
    @path = path
    read
  end

  def read
    @sections = File.readlines(path).slice_before(/^\s*#\s*section|end/).map { |data| Section.new data }
  end

  def to_s
    @sections.join.to_s
  end

  def summary
    @sections.map(&:summary).compact
  end

  def sections
    @sections.select(&:section?)
  end

  def enabled_sections
    sections.select(&:enabled?).map(&:name)
  end

  def disabled_sections
    sections.reject(&:enabled?).map(&:name)
  end

  def save
    File.write(@path, self)
  end

  def [](section_name)
    @sections.find { |s| s.name == section_name }
  end
end