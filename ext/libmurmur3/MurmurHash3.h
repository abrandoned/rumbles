#ifndef MURMUR_PLATFORM_H
#define MURMUR_PLATFORM_H

  void SetAffinity ( int cpu );
  #include <stdint.h>
  #include <strings.h>

  #define	FORCE_INLINE __attribute__((always_inline))

  FORCE_INLINE uint32_t rotl32 ( uint32_t x, int8_t r ){ return (x << r) | (x >> (32 - r)); }
  FORCE_INLINE uint64_t rotl64 ( uint64_t x, int8_t r ){ return (x << r) | (x >> (64 - r)); }
  FORCE_INLINE uint32_t rotr32 ( uint32_t x, int8_t r ){ return (x >> r) | (x << (32 - r)); }
  FORCE_INLINE uint64_t rotr64 ( uint64_t x, int8_t r ){ return (x >> r) | (x << (64 - r)); }
  FORCE_INLINE unsigned long long int rdtsc(){ unsigned long long int x; __asm__ volatile ("rdtsc" : "=A" (x)); return x; }

  #define	ROTL32(x,y)	rotl32(x,y)
  #define ROTL64(x,y)	rotl64(x,y)
  #define	ROTR32(x,y)	rotr32(x,y)
  #define ROTR64(x,y)	rotr64(x,y)
  #define BIG_CONSTANT(x) (x##LLU)
  #define _stricmp strcasecmp

#endif 
/* endif MURMUR_PLATFORM_H */

#ifdef __cplusplus
  extern "C" {
#endif

void MurmurHash3_x86_32( const void * key, int len, uint32_t seed, void * out );
void MurmurHash3_x86_64( const void * key, int len, uint32_t seed, void * out );
void MurmurHash3_x86_128( const void * key, int len, uint32_t seed, void * out );
void MurmurHash3_x64_32( const void * key, int len, uint32_t seed, void * out );
void MurmurHash3_x64_64( const void * key, int len, uint32_t seed, void * out );
void MurmurHash3_x64_128( const void * key, int len, uint32_t seed, void * out );
#ifdef __cplusplus
  }
#endif
