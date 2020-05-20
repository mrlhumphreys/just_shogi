require 'minitest/autorun'
require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/narigin'

describe JustShogi::Narigin do
  it 'inherits from kin base' do
    assert_includes(JustShogi::Narigin.ancestors, JustShogi::KinBase)
  end
end

