require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/tokin'

describe JustShogi::Tokin do
  it 'inherits from kin base' do
    assert_includes(JustShogi::Tokin.ancestors, JustShogi::KinBase)
  end
end

