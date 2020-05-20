require 'minitest/autorun'
require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/narikei'

describe JustShogi::Narikei do
  it 'inherits from kin base' do
    assert_includes(JustShogi::Narikei.ancestors, JustShogi::KinBase)
  end
end

