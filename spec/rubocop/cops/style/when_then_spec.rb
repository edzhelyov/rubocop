# encoding: utf-8

require 'spec_helper'

module Rubocop
  module Cop
    module Style
      describe WhenThen do
        let(:cop) { WhenThen.new }

        it 'registers an offence for when x;' do
          inspect_source(cop, ['case a',
                              'when b; c',
                              'end'])
          expect(cop.offences.map(&:message)).to eq(
            ['Never use "when x;". Use "when x then" instead.'])
        end

        it 'accepts when x then' do
          inspect_source(cop, ['case a',
                              'when b then c',
                              'end'])
          expect(cop.offences.map(&:message)).to be_empty
        end

        it 'accepts ; separating statements in the body of when' do
          inspect_source(cop, ['case a',
                              'when b then c; d',
                              'end',
                              '',
                              'case e',
                              'when f',
                              '  g; h',
                              'end'])
          expect(cop.offences.map(&:message)).to be_empty
        end

        it 'auto-corrects "when x;" with "when x then"' do
          new_source = autocorrect_source(cop, ['case a',
                                                'when b; c',
                                                'end'])
          expect(new_source).to eq("case a\nwhen b then c\nend")
        end
      end
    end
  end
end
