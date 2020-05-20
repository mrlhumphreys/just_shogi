require 'minitest/autorun'
require 'minitest/spec'
require 'just_shogi/pieces/gyokushou'

describe JustShogi::Gyokushou do
  it 'inherits from ou base' do
    assert_includes(JustShogi::Gyokushou.ancestors, JustShogi::OuBase)
  end
end
