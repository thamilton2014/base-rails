# app/lib/docker.rb
class Docker
  # The configuration object to set the state.
  attr_accessor :config

  # Customize the default settings for docker commands using block.
  #
  # Example:
  #   Docker.configure do |config|
  #     config.delivery_id  = 'test_id'
  #     config.ref_tree     = 'test_ref_tree'
  #     config.spec         = YAML.load_file('test_file.yml')
  #   end
  class << self
    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end

    # The default docker client object.
    def default
      @@default ||= Docker.new
    end

    # The docker information
    def info
      system('docker', '--version')
    end
  end

  # @param [Configuration] config - The initial configuration object.
  def initialize(config = Configuration.default)
    @config = config
  end

  # Starts the docker container in the background and waits.
  def startup
    system('docker', 'run', '-dit', '-v', "#{Dir.pwd}/#{config.tmp_folder}/#{config.repository_name}:/opt/current", '--workdir', '/opt/current', '--entrypoint', '/bin/bash', '--name', config.ref_tree, config.spec['languages'])
  end

  # Stops the docker container.
  def exit
    system('docker', 'rm', '-f', config.ref_tree)
  end

  # Executes each step in the phase.
  # @param [Hash] phase - The list of commands in the array.
  def execute(phase)
    results = {}
    phase['commands'].each do |command|
      results[command] = run(command)
    end
    results
  end

  # This runs commands inside a docker container.
  # @param [String] command - The docker container command to run.
  def run(command)
    system('docker', 'exec', config.ref_tree, '/bin/bash', '-c', command)
  end

end # => end Docker
