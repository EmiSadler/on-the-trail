#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "background-1" asset catalog image resource.
static NSString * const ACImageNameBackground1 AC_SWIFT_PRIVATE = @"background-1";

/// The "blue-figure" asset catalog image resource.
static NSString * const ACImageNameBlueFigure AC_SWIFT_PRIVATE = @"blue-figure";

/// The "flag-france" asset catalog image resource.
static NSString * const ACImageNameFlagFrance AC_SWIFT_PRIVATE = @"flag-france";

/// The "flag-uk" asset catalog image resource.
static NSString * const ACImageNameFlagUk AC_SWIFT_PRIVATE = @"flag-uk";

#undef AC_SWIFT_PRIVATE
