require_relative './spec_helper'
require_relative './shared_context'

require 'fog/kubevirt'

describe Fog::Compute do
  before :all do
    vcr = KubevirtVCR.new(
      vcr_directory: 'spec/fixtures/kubevirt/server',
      :service_class => Fog::Kubevirt::Compute
    )
    @service = vcr.service
  end

  it 'gets server created from openshift template' do
    VCR.use_cassette('get_server_from_openshift_template') do
      server = @service.get_server('rhel9-arm64-scarlet-ladybug-27')

      assert(server)

      assert_equal(server[:memory], '2Gi')
      assert_equal(server[:cpu_cores], 1)
    end
  end
end