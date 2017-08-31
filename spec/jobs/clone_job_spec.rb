require 'rails_helper'
# https://relishapp.com/rspec/rspec-rails/docs/matchers/have-enqueued-job-matcher

RSpec.describe CloneJob, type: :job do
  it "matches with enqueued job" do
    ActiveJob::Base.queue_adapter = :test
    expect {CloneJob.perform_later}.to have_enqueued_job(CloneJob)
  end

  it "matches with enqueued job with parameters" do
    ActiveJob::Base.queue_adapter = :test
    expect {CloneJob.perform_later("123abc", "abc123")}.to have_enqueued_job.with("123abc", "abc123")
  end

  it "matches with with enqueued job with the job queue name" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      CloneJob.perform_later
    }.to have_enqueued_job.on_queue("default")
  end
end
