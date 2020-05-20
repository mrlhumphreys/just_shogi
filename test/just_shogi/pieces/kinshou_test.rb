require 'minitest/autorun'
require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/kinshou'

describe JustShogi::Kinshou do
  it 'inherits from kin base' do
    assert_includes(JustShogi::Kinshou.ancestors, JustShogi::KinBase)
  end
end

