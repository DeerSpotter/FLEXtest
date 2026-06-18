#import "libFLEX.h"
#import "Classes/Manager/FLEXManager.h"
#import "Classes/Toolbar/FLEXWindow.h"

id FLXGetManager(void) {
    return [FLEXManager sharedManager];
}

SEL FLXRevealSEL(void) {
    return @selector(showExplorer);
}

Class FLXWindowClass(void) {
    return [FLEXWindow class];
}
