# frozen_string_literal: true

require_relative 'test_helper'

class SimpleMorphogen
  include Morphogen
end

describe SimpleMorphogen do
  before do
    @morph = SimpleMorphogen.new(char: 'S')
  end

  describe '#name' do
    it 'must have a name' do
      @morph.name.wont_be_nil
    end
  end

  describe '#color' do
    it 'must have a color' do
      @morph.color.wont_be_nil
    end

    it 'must be a 6-character hex string' do
      @morph.color.must_match(/#[0-9A-F]{6}$/)
    end
  end
end
