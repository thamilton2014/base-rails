# spec/lib/configuration_spec.rb
require 'rails_helper'

RSpec.describe 'Configuration Object' do

  describe 'when I configure the object using a block' do
    let(:config) {Configuration.default}

    before do
      Configuration.default.configure do |c|
        c.delivery_id          = "test-delivery-id"
        c.ref_tree             = "test-ref-tree"
        c.spec_name            = 'test-spec-name'
        c.repository_name      = 'test-repository-name'
        c.repository_full_name = 'test-repository-full-name'
        c.repository_html_url  = 'test-repository-html-url'
        c.repository_url       = 'test-repository-url'
      end
    end

    # Test suite for instantiating the configuration object using a block.
    it 'should contain default block values' do
      expect(config.delivery_id).not_to be_empty
      expect(config.delivery_id).to eql('test-delivery-id')
      expect(config.ref_tree).to eql('test-ref-tree')
      expect(config.repository_name).to eql('test-repository-name')
      expect(config.repository_full_name).to eql('test-repository-full-name')
      expect(config.tmp_folder).to eql('tmp/github/test-delivery-id')
    end
  end

  # Test suite for instantiating the configuration block.
  describe 'when I call the default value' do
    let(:new_config) {Configuration.new}

    it 'returns a configuration object with default value' do
      expect(new_config.delivery_id).to be_empty
      expect(new_config.ref_tree).to be_empty
      expect(new_config.spec_name).to eql('buildspec.yml')
    end
  end
end