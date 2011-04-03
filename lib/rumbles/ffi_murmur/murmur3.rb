module Rumbles::Murmur3
  extend FFI::Library
  ffi_lib "#{Rumbles::FFI_LIB_DIR}/libmurmur3.#{Rumbles::LIB_EXT}"
  attach_function :MurmurHash3_x86_32, [:pointer, :int, :uint32, :pointer], :void
  attach_function :MurmurHash3_x86_128, [:pointer, :int, :uint32, :pointer], :void    
  attach_function :MurmurHash3_x64_128, [:pointer, :int, :uint32, :pointer], :void    
end

module Rumbles::Murmur3
  def self.[](hash_func, str, seed)
    output_ptr = FFI::MemoryPointer.new :pointer
    case hash_func.to_s.downcase
    when "murmurhash3", "mm3", "x86_32", "mm32"
      self.MurmurHash3_x86_32(str, str.bytesize, seed, output_ptr)
    when "murmurhash3_x86_128", "x86_128"
      self.MurmurHash3_x86_128(str, str.bytesize, seed, output_ptr)
    when "murmurhash3_x64_128", "x64_128"
      self.MurmurHash3_x64_128(str, str.bytesize, seed, output_ptr)
    else
      raise "Invalid Murmur3 hash, try [:x86_32, :x86_128, :x64_128]"
    end
    
    # really don't think this is reading the 128, need to test against actual usage
    return output_ptr.read_ulong_long
  end
end
