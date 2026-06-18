#import "libFLEX.h"
#import "Classes/Manager/FLEXManager.h"

id FLXGetManager(void) {
    return [FLEXManager sharedManager];
}

SEL FLXRevealSEL(void) {
    return @selector(showExplorer);
}

Class FLXWindowClass(void) {
    return NSClassFromString(@"FLEXWindow");
}
