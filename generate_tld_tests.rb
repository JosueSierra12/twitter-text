#!/usr/bin/env ruby

require 'yaml'

`./get_tlds.rb`

test_yml = { 'tests' => { } }

path = File.join(File.dirname(__FILE__), 'tlds.yml')
yml = YAML.load_file(path)
yml.each do |type, tlds|
  test_yml['tests'][type] = []
  tlds.each do |tld|
    test_yml['tests'][type].push(
      'description' => "#{tld} is a valid #{type} tld",
      'text' => "https://twitter.#{tld}",
      'expected' => true,
    )
  end
end

File.open('tlds.yml', 'w') do |file|
  file.write(test_yml.to_yaml)
end
