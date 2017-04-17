
// Based on https://github.com/jspahrsummers/libextobjc/blob/master/extobjc/EXTScope.h
// The library is huge, compiles with warnings and has dependencies that compile with warnings.
// Instead, we're just defining weakify and strongify here, minus the multiple arguments and the @ hack
#define weakify(VAR) \
__weak __typeof__(VAR) VAR ## _weak_ = (VAR)

#define strongify(VAR) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof__(VAR) VAR = VAR ## _weak_ \
_Pragma("clang diagnostic pop")
