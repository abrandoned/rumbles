require 'ffi'
require 'rbconfig'

module Rumbles
  FFI_LIB_DIR = "#{File.expand_path(File.dirname(__FILE__)) + "/rumbles/ffi_murmur/lib"}"
  LIB_EXT = Config::MAKEFILE_CONFIG['DLEXT']
end

require 'rumbles/ruby/murmur2/neutral'
require 'rumbles/ffi_murmur/murmur1'
require 'rumbles/ffi_murmur/murmur2'
require 'rumbles/ffi_murmur/murmur3'

