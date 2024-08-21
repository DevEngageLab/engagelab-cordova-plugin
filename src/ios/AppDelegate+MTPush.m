

#import "AppDelegate+MTPush.h"
#import "MTPushEngagelabApi.h"

#import <objc/runtime.h>
#import <AdSupport/AdSupport.h>
#import <UserNotifications/UserNotifications.h>
#import "MTPushEngagelab.h"


@implementation AppDelegate(MTPush)

+(void)load{
   static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           Class class = [self class];
           
           SEL originalSelector = @selector(init);
           SEL swizzledSelector = @selector(init_plus);
           
           Method origin = class_getInstanceMethod(class, originalSelector);
           Method swizzle = class_getInstanceMethod(class, swizzledSelector);
           
           BOOL didAddMethod =
           class_addMethod(class,
                           originalSelector,
                           method_getImplementation(swizzle),
                           method_getTypeEncoding(swizzle));
           
           if (didAddMethod) {
               class_replaceMethod(class,
                                   swizzledSelector,
                                   method_getImplementation(origin),
                                   method_getTypeEncoding(origin));
           } else {
               method_exchangeImplementations(origin, swizzle);
           }
       });
}

-(instancetype)init_plus{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidLaunch:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    return [self init_plus];
}


-(void)applicationDidLaunch:(NSNotification *)notification{
    [[MTPushEngagelabApi shareSingleton] applicationDidLaunch:notification];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[MTPushEngagelabApi shareSingleton] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

@end
