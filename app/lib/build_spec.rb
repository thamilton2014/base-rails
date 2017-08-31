# app/lib/build_spec.rb
require 'fileutils'
require 'octokit'

class BuildSpec
  attr_reader :client

  # @param [Docker] client - The default docker client to use.
  def initialize(client = Docker.default)
    @client = client
    # state - pending | success | failure | error
    @gh = Octokit::Client.new(:access_token => "ed920b64b6ff2203022ea81e89d5b1845ea9bff3")
    # client.startup
  end

  # Create a folder structure based on the configuration
  def create_folder
    unless File.directory?(client.config.tmp_folder)
      FileUtils.mkdir_p(client.config.tmp_folder)
    end
  end

  # Clone a repository to the tmp folder based on the configuration.
  def clone_repository
    `cd #{client.config.tmp_folder} && git clone #{client.config.repository_url}.git`
    `cd #{client.config.tmp_folder}/#{client.config.repository_name} && git fetch origin #{client.config.ref_tree} && git reset --hard FETCH_HEAD`
  end

  def startup
    client.startup
  end

  #
  # Pre phase - Where the initial container setup is done.
  #
  def pre
    if phase.has_key?('pre')
      execute("pre", phase['pre'])
    end
  end

  #
  # Test phase - Where tests are usually run.
  #
  def test
    if phase.has_key?('test')
      execute("test", phase['test'])
    end
  end

  #
  # Build phase - Where code is compiled or archived.
  #
  def build
    if phase.has_key?('build')
      execute("build", phase['build'])
    end
  end

  #
  # Post phase - Where logging or pushing to artifacts is done.
  #
  def post
    if phase.has_key?('post')
      execute("post", phase['post'])
    end
  end

  #
  # Deploy phase - Where build artifacts are pushed.
  #
  def deploy
    if phase.has_key?('deploy')
      execute("deploy", phase['deploy'])
    end
  end

  #
  # When we need to delete/remove the client.
  #
  def done
    client.exit
  end

  private

  def execute(name, phase)
    # Convert key's to string because nil == "". I then use a ternary to set default values.
    options = {
        context:     "[#{name}-phase]",
        target_url:  phase['target_url'].to_s.empty? ? "" : phase['target_url'],
        description: phase['description'].to_s.empty? ? "#{name} phase context" : phase['description']
    }

    @gh.create_status(client.config.repository_full_name, client.config.ref_tree, "pending", options)
    begin
      results = client.execute(phase)
      if results.has_value?(false)
        @gh.create_status(client.config.repository_full_name, client.config.ref_tree, "failure", options)
      else
        @gh.create_status(client.config.repository_full_name, client.config.ref_tree, "success", options)
      end
    rescue Exception => e
      @gh.create_status(client.config.repository_full_name, client.config.ref_tree, "error", options)
    end
  end

  def phase
    client.config.spec['phases']
  end

end # => end BuildSpec