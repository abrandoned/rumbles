module Rumbles::Murmur1
  extend FFI::Library
  ffi_lib "#{Rumbles::FFI_LIB_DIR}/libmurmur1.#{Rumbles::LIB_EXT}"
  attach_function :MurmurHash1, [:pointer, :int, :uint32], :uint32
  attach_function :MurmurHash1Aligned, [:pointer, :int, :uint32], :uint32
end

module Rumbles::Murmur1
  def self.[](hash_func, str, seed)
    case hash_func.to_s.downcase
    when "murmurhash1", "hash1", "mm1"
      self.MurmurHash1(str, str.bytesize, seed)
    when "murmurhash1aligned", "aligned"
      self.MurmurHash1Aligned(str, str.bytesize, seed)
    else
      raise "Invalid Murmur1 hash, use only [:hash1, :aligned, :mm1]"
    end
  end
end
