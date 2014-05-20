describe HostsFile do
  subject { hosts }
  let(:hosts) { HostsFile.new('spec/data/hosts') }

  describe '[]' do
    it 'should find a section by name' do
      expect(hosts['one'].name).to eq 'one'
    end

    it 'should return nil on a bogus name' do
      expect(hosts['not_real']).to be_nil
    end
  end

  describe 'to_s' do
    subject { hosts.to_s }
    it { should end_with "# end\n" }
    it { should start_with '# A static comment' }
    it { should include '# section one ON' }
  end

end
