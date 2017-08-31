# spec/lib/docker_spec.rb
require 'rails_helper'
RSpec.describe 'Docker Object' do
  let(:config) {Configuration.new}
  let(:docker) {Docker.new(config)}

  # Test suite for instantiating Docker with a block.
  describe 'when I configure the docker object using a block' do
    it 'returns a docker object we can use to interface with' do
      expect(docker.config.delivery_id).to be_empty
      expect(docker.config.ref_tree).to be_empty
      expect(docker.config.spec_name).to eql('buildspec.yml')
    end
  end

  # Test suite for calling docker info.
  describe 'docker info' do
    context 'when docker is running' do
      it 'should return true for successfully completing the system command' do
        allow(Docker).to receive('info').and_return(true)
        expect(Docker.info).to be true
      end
    end
  end

  # Test suite for calling docker startup
  describe 'docker startup' do
    context 'when docker is running' do
      it 'returns a valid boolean result' do
        allow(docker).to receive('startup').and_return(true)
        expect(docker.startup)
      end
    end
  end

end # => end Docker Tests