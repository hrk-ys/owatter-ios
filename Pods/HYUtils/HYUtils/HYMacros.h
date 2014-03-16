//
//  HYMacros.h
//

#define S(fmat, ...) [NSString stringWithFormat:fmat, ##__VA_ARGS__]
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#define LOG(format, ...)    DDLogCVerbose(format, ##__VA_ARGS__)
#define LOGTrace            DDLogCVerbose(@"")
#define LOGInfoTrace        DDLogCInfo(@"")
