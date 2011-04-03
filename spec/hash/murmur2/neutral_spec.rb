require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Murmur2 Neutral" do
  describe "hashes with changing seed" do
    expected = [ 0xeef8be32, 0x8109dec6, 0x9aaf4192, 0xc1bcaf1c,
                 0x821d2ce4, 0xd45ed1df, 0x6c0357a7, 0x21d4e845,
                 0xfa97db50, 0x2f1985c8, 0x5d69782a, 0x0d6e4b85,
                 0xe7d9cf6b, 0x337e6b49, 0xe1606944, 0xccc18ae8 ]
    
    let(:test_bytes) { [0x4e, 0xe3, 0x91, 0x00, 0x10, 0x8f, 0xff].pack("c*") }
    
    expected.length.times do |num|
      describe "Ruby Neutral" do
        it "returns #{expected[num]} when seed is #{num}" do
          Rumbles::Murmur2Ruby.Neutral(test_bytes, num, :str => false).should eq(expected[num])
        end
      end
      
      describe "FFI Neutral" do
        it "returns #{expected[num]} when seed is #{num}" do
          Rumbles::Murmur2.MurmurHashNeutral2(test_bytes, test_bytes.length, num).should eq(expected[num])
        end
      end
    end
  end
  
  describe "hashes with changing key" do                
    expected = [ 0xd743ae0b, 0xf1b461c6, 0xa45a6ceb, 0xdb15e003,
                 0x877721a4, 0xc30465f1, 0xfb658ba4, 0x1adf93b2,
                 0xe40a7931, 0x3da52db0, 0xbf523511, 0x1efaf273,
                 0xe628c1dd, 0x9a0344df, 0x901c99fc, 0x5ae1aa44 ]
                 
    def key(start, size)
      ret_key = []
      
      size.times do |num|
        ret_key << ((num + start) & 255)
      end
      
      return ret_key.pack("c*")
    end
    
    expected.length.times do |num|
      describe "Ruby Neutral" do
        it "returns #{expected[num]} on key change #{num}" do
          Rumbles::Murmur2Ruby.Neutral(key(num, 133), 0x1234ABCD, :str => false).should eq(expected[num])
        end
      end

      describe "FFI Neutral" do
        it "returns #{expected[num]} on key change #{num}" do
          Rumbles::Murmur2.MurmurHashNeutral2(key(num, 133), 133, 0x1234ABCD).should eq(expected[num])
        end
      end
    end                 
  end

  describe "hashes with changing key and lengths" do                
    expected = [ 0xa0c72f8e, 0x29c2f97e, 0x00ca8bba, 0x88387876,
                 0xe203ce49, 0x58d75952, 0xab84febe, 0x98153c65,
                 0xcbb38375, 0x6ea1a28b, 0x9afa8f55, 0xfb890eb6,
                 0x9516cc49, 0x6408a8eb, 0xbb12d3e6, 0x00fb7519 ]
                 
    def key(start, size)
      ret_key = []
      
      size.times do |num|
        ret_key << ((num + start) & 255)
      end
      
      return ret_key.pack("c*")
    end
    
    expected.length.times do |num|
      describe "Ruby Neutral" do
        it "returns #{expected[num]} on key change #{num}" do
          Rumbles::Murmur2Ruby.Neutral(key(num, num), 0x7870AAFF, :str => false).should eq(expected[num])
        end
      end

      describe "FFI Neutral" do
        it "returns #{expected[num]} on key change #{num}" do
          Rumbles::Murmur2.MurmurHashNeutral2(key(num, num), num, 0x7870AAFF).should eq(expected[num])
        end
      end
    end                 
  end  
end
