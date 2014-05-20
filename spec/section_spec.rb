describe Section do
  describe '#initialize' do
    subject { Section.new data }

    context 'with a section' do
      let(:data) { [header, '1.2.3.4 domain'] }
      let(:header) { '#section foo bar' }

      context 'without a space after #' do
        describe 'and no status' do
          it 'should parse the name' do
            expect(subject.name).to eq 'foo bar'
          end

          it { should be_enabled }
        end

        describe 'and a status of ON' do
          let(:header) { '#section foo bar ON' }
          it 'should parse the name' do
            expect(subject.name).to eq 'foo bar'
          end

          it { should be_enabled }
        end

        describe 'and a status of OFF' do
          let(:header) { '#section foo bar OFF' }
          it 'should parse the name' do
            expect(subject.name).to eq 'foo bar'
          end

          it { should_not be_enabled }
        end
      end

      context 'with a space before and after #' do
        describe 'and no status' do
          it 'should parse the name' do
            expect(subject.name).to eq 'foo bar'
          end

          it { should be_enabled }
        end

        describe 'and a status of ON' do
          let(:header) { ' # section foo bar ON' }
          it 'should parse the name' do
            expect(subject.name).to eq 'foo bar'
          end

          it { should be_enabled }
        end

        describe 'and a status of OFF' do
          let(:header) { ' # section foo bar OFF' }
          it 'should parse the name' do
            expect(subject.name).to eq 'foo bar'
          end

          it { should_not be_enabled }
        end
      end

      it 'should not have the header in the data' do
        expect(subject.data).to eq data.drop(1)
      end
    end

    context 'with raw data' do
      let(:data) { ['1.2.3.4 domain'] }
      it { should be_enabled }
      it 'should not have a name' do
        expect(subject.name).to be_nil
      end
      it 'should not have a header' do
        expect(subject.header).to be_nil
      end

      it 'should not alter the data' do
        expect(subject.data).to eq data
      end
    end
  end
end
