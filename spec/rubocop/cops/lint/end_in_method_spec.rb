# encoding: utf-8

require 'spec_helper'

module Rubocop
  module Cop
    module Lint
      describe EndInMethod do
        let(:cop) { EndInMethod.new }

        it 'reports an offence for def with an END inside' do
          src = ['def test',
                 '  END { something }',
                 'end']
          inspect_source(cop, src)
          expect(cop.offences.size).to eq(1)
        end

        it 'reports an offence for defs with an END inside' do
          src = ['def self.test',
                 '  END { something }',
                 'end']
          inspect_source(cop, src)
          expect(cop.offences.size).to eq(1)
        end

        it 'accepts END outside of def(s)' do
          src = ['END { something }']
          inspect_source(cop, src)
          expect(cop.offences).to be_empty
        end
      end
    end
  end
end
