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

  it 'gets server created from fog-kubevirt' do
    VCR.use_cassette('get_server_from_fog_kubevirt') do
      server = @service.get_server('todd-vessell.foreman-isc.lan')

      assert(server)

      assert_equal(server[:memory], '1Gi')
      assert_equal(server[:cpu_cores], 1)
    end
  end
end