require 'spec_helper'

describe 'riak2' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "riak2 class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('riak2') }
          it { is_expected.to contain_class('riak2::params') }
          it { is_expected.to contain_class('riak2::install').that_comes_before('riak2::config') }
          it { is_expected.to contain_class('riak2::config') }
          it { is_expected.to contain_class('riak2::service').that_subscribes_to('riak2::config') }

          it { is_expected.to contain_service('riak') }
          it { is_expected.to contain_package('riak').with_ensure('present') }
          case facts[:osfamily]
          when 'RedHat'
            it { is_expected.to contain_class('riak2::repository::el') }
            it { is_expected.to contain_yumrepo('basho_riak') }
          when 'Debian'
            it { is_expected.to contain_class('riak2::repository::debian') }
            it { is_expected.to contain_apt__source('riak') }
          end


        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'riak2 class without any parameters on Plan9' do
      let(:facts) {{
        :osfamily        => 'plan9',
        :operatingsystem => 'plan9',
      }}

      it { expect { is_expected.to contain_package('riak') }.to raise_error(Puppet::Error, /plan9 not supported/) }
    end
  end
end
