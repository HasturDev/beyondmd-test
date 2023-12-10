require 'rspec'
require 'vagrant'

describe 'Vagrantfile' do
  it 'configures the VM with the correct box' do
    config = Vagrant::Config.run do |config|
      load 'Vagrantfile'
    end

    expect(config.vm.box).to eq 'debian-sandbox/bookworm64'
  end

  it 'configures the VM with a private network' do
    config = Vagrant::Config.run do |config|
      load 'Vagrantfile'
    end

    expect(config.vm.networks).to include('private_network')
    expect(config.vm.networks['private_network']).to include(type: 'dhcp')
  end

  it 'provisions the VM with Ansible' do
    config = Vagrant::Config.run do |config|
      load 'Vagrantfile'
    end

    expect(config.vm.provisioners).to include('ansible')
    expect(config.vm.provisioners['ansible']).to include(playbook: 'docker_install.yml')
  end
end