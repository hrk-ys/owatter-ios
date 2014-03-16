//
//  NSError+Extension.m
//

#import "NSError+Extension.h"

#import "DDLog.h"

@implementation NSError (Extension)

- (void)show
{
    if (! [NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{ [self show]; });
        return;
    }
    
    UIAlertView *alert;
    alert =
    [[UIAlertView alloc] initWithTitle:self.localizedDescription message:self.localizedFailureReason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

@end
