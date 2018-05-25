require 'spec_helper'

describe Beaker::Puppeter do
  it 'has a version number' do
    expect(Beaker::Puppeter::VERSION).not_to be nil
  end

  it 'version number is semantic' do
    expect(Beaker::Puppeter::VERSION).to match /^\d+\.\d+\.\d+$/
  end
end
