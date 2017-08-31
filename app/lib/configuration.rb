# app/lib/configuration.rb
class Configuration
  # Current GitHub delivery id used by the headers.
  attr_accessor :delivery_id

  # Current GitHub reference tree.
  attr_accessor :ref_tree

  # Current build spec file.
  attr_accessor :spec_name

  # Current repository name
  attr_accessor :repository_name

  # Current repository full name
  attr_accessor :repository_full_name

  # Current repository html url
  attr_accessor :repository_html_url

  # Current repository url
  attr_accessor :repository_url

  def initialize
    @delivery_id = ''
    @ref_tree    = ''
    @spec_name   = 'buildspec.yml'
  end

  # The default configuration object.
  def self.default
    @@default ||= Configuration.new
  end

  # This is the main block we use to configure the the object.
  def configure
    yield(self) if block_given?
  end

  # This is the main location for the spec file.
  def spec
    YAML.load_file("#{tmp_folder}/#{repository_name}/#{spec_name}")
  end

  # This is the main location for the temp folder.
  def tmp_folder
    "tmp/github/#{delivery_id}"
  end

end # => end Configuration
