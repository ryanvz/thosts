DEFAULT_PATH = '/etc/hosts'

class HostsFile
  def initialize(path = DEFAULT_PATH)
    @path = path
    @content = File.read path
  end

  def save
    File.write(@path, @content)
  end

  def toggle_section(section_name)
    @content.gsub(/^[ \t]*#\s*section\s*#{ section_name }\s*(?<old_status>OFF|ON)?.*?^\s*#end/m) do |section|
      active = $~[:old_status] == 'OFF' ? true : false
      puts "Section #{section_name} now #{active ? 'on' : 'off'}"
      if active
        section.gsub(/^(\s*)#+(\s*)(?=\d)/, '\1\2')
      else
        section.gsub(/^[ #\t]*(?=\d)/, '#')
      end.sub(/^\s*#\s*section.*$/, "# section #{section_name} #{ active ? 'ON' : 'OFF' }")
    end
  end
end
