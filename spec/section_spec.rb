describe Section do
  subject { section }
  let(:section) { Section.new data }
  let(:data) { [header, '1.2.3.4 domain'] }
  let(:header) { "#section foo bar #{status}" }
  let(:status) { 'ON' }

  describe '#initialize' do
    context 'with a section' do
      let(:data) { [header, '1.2.3.4 domain'] }
      let(:status) { '' }

      context 'without a space after #' do
        describe 'and no status' do
          it 'should parse the name' do
            expect(section.name).to eq 'foo bar'
          end

          it { should be_enabled }
        end

        describe 'and a status of ON' do
          let(:status) { 'ON' }
          it 'should parse the name' do
            expect(section.name).to eq 'foo bar'
          end

          it { should be_enabled }
        end

        describe 'and a status of OFF' do
          let(:status) { 'OFF' }
          it 'should parse the name' do
            expect(section.name).to eq 'foo bar'
          end

          it { should_not be_enabled }
        end
      end

      context 'with a space before and after #' do
        let(:header) { " # section foo bar #{status}" }

        describe 'and no status' do
          it 'should parse the name' do
            expect(section.name).to eq 'foo bar'
          end

          it { should be_enabled }
        end

        describe 'and a status of ON' do
          let(:status) { 'ON' }
          it 'should parse the name' do
            expect(section.name).to eq 'foo bar'
          end

          it { should be_enabled }
        end

        describe 'and a status of OFF' do
          let(:status) { 'OFF' }
          it 'should parse the name' do
            expect(section.name).to eq 'foo bar'
          end
          it { should_not be_enabled }
        end
      end

      it 'should not have the header in the data' do
        expect(section.data).to eq data.drop(1)
      end
    end

    context 'with raw data' do
      let(:data) { ['1.2.3.4 domain'] }
      it { should be_enabled }
      it 'should not have a name' do
        expect(section.name).to be_nil
      end
      it 'should not have a header' do
        expect(section.header).to be_nil
      end

      it 'should not alter the data' do
        expect(section.data).to eq data
      end
    end
  end

  describe '#header' do
    subject { section.header.chomp }
    it { should end_with status  }
    it { should start_with '#' }
    it { should include section.name }
  end

  describe '#to_s' do
    subject { section.to_s }
    it { should start_with section.header }
    it { should end_with section.data.last }
  end
end
