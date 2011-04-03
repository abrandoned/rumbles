module Rumbles::Murmur2
  extend FFI::Library
  ffi_lib "#{Rumbles::FFI_LIB_DIR}/libmurmur2.#{Rumbles::LIB_EXT}"
  attach_function :MurmurHashNeutral2, [:pointer, :int, :uint32], :uint32
  attach_function :MurmurHash2, [:pointer, :int, :uint32], :uint32
  attach_function :MurmurHash2A, [:pointer, :int, :uint32], :uint32
  attach_function :MurmurHashAligned2, [:pointer, :int, :uint32], :uint32
  attach_function :MurmurHash64A, [:pointer, :int, :uint64], :uint64
  attach_function :MurmurHash64B, [:pointer, :int, :uint64], :uint64
end

module Rumbles::Murmur2
  def self.[](hash_func, str, seed)
    case hash_func.to_s.downcase
    when "murmurhash2", "hash2", "mm2"
      self.MurmurHash2(str, str.bytesize, seed)
    when "murmurhash2aligned", "aligned"
      self.MurmurHashAligned2(str, str.bytesize, seed)
    when "murmurhash2a", "hash2a", "mm2a"
      self.MurmurHash2A(str, str.bytesize, seed)
    when "murmurhash2neutral", "neutral"
      self.MurmurHashNeutral2(str, str.bytesize, seed)
    when "murmurhash264", "mm64", "mm64a"
      self.MurmurHash64A(str, str.bytesize, seed)
    when "murmurhash264b", "mm64b"
      self.MurmurHash64B(str, str.bytesize, seed)
    else
      raise "Invalid Murmur2 hash, try [:hash2, :aligned, :neutral, :hash2a, :mm64, or :mm64b]"
    end
  end
end
