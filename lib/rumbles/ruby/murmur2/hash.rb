module Rumbles
  module Murmur2Ruby
    def self.Hash2(key_bytes, seed, opts={})
      opts = {:str => true}.merge!(opts)
      m = 0x5bd1e995
      r = 24
      len = opts[:str] ? key_bytes.bytesize : key_bytes.length
      h = (seed ^ len) & 4294967295
      data = key_bytes.dup
      data = data.bytes.to_a if opts[:str]
      data_point = 0
      
      while len >= 4 do
        k = data[data_point]
        
        k = k * m & 4294967295
        k = k ^ (k >> r) 
        k = k * m & 4294967295
        
        h = h * m & 4294967295
        h = (h ^ k) 
        
        len = len - 4
        data_point = data_point + 4
      end      
      
      if len >= 1
        h = h ^ ((data[data_point + 2] << 16) & 4294967295) if len > 2
        h = h ^ ((data[data_point + 1] << 8) & 4294967295) if len > 1
        h = h ^ data[data_point] 
        h = h * m & 4294967295
      end
      
      h = h ^ (h >> 13) 
      h = h * m & 4294967295
      h = h ^ (h >> 15)
    end
    
    def self.Hash2A(key_bytes, seed, opts={})
      opts = {:str => true}.merge!(opts)
      m = 0x5bd1e995
      r = 24
      len = opts[:str] ? key_bytes.bytesize : key_bytes.length
      h = seed & 4294967295
      data = key_bytes.dup
      data = data.bytes.to_a if opts[:str]
      data_point = 0
      t = 0
      
      mmix = lambda do |h, k| 
        k = k * m & 4294967295 
        k = k ^ (k >> r) 
        k = k * m & 4294967295 
        h = h ^ k
      end

      while len >= 4 do
        k = data[data_point]
        h = mmix.call(h, k)
        data_point = data_point + 4
        len = len - 4
      end
      
      if len >= 1
        t = t ^ ((data[data_point + 2] << 16) & 4294967295) if len > 2
        t = t ^ ((data[data_point + 1] << 8) & 4294967295) if len > 1
        t = t ^ data[data_point] 
      end
      
      h = mmix.call(h, t)
      h = mmix.call(h, l)
      
      h = h ^ (h >> 13) 
      h = h * m & 4294967295
      h = h ^ (h >> 15)
    end
  end
end
