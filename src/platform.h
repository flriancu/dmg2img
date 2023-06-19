#ifdef __GNUC__
#   define ATTRIBUTE_PACKED __attribute__((__packed__));
#else
#   define ATTRIBUTE_PACKED
#endif

#define RESERVED_FIELD_NAME __reserved_field_name

#ifdef WIN32
#   define fseeko _fseeki64
#endif

#ifdef _MSC_VER 
#   define strcasecmp _stricmp
#endif
