# app/jobs/clone_job.rb
# http://edgeguides.rubyonrails.org/testing.html#testing-jobs
class CloneJob < ApplicationJob
  queue_as :default

  def perform(head_params, repo_params)
    # TODO - I need to make sure Docker is running.
    # Docker.configure do |config|
    #   config.delivery_id          = args[0]
    #   config.ref_tree             = args[1].sha
    #   config.repository_name      = args[1].name
    #   config.repository_full_name = args[1].full_name
    #   config.repository_html_url  = args[1].html_url
    #   config.repository_url       = args[1].url
    # end

    #
    # spec = BuildSpec.new
    # spec.create_folder
    # spec.clone_repository
    # spec.startup
    # spec.pre
    # spec.test
    # spec.build
    # spec.post
    # spec.deploy
    # spec.done

  end
end # => end CloneJob
