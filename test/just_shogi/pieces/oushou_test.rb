require 'minitest/autorun'
require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/oushou'

describe JustShogi::Oushou do
  it 'inherits from ou base' do
    assert_includes(JustShogi::Oushou.ancestors, JustShogi::OuBase)
  end
end

