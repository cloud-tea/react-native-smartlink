#import "CDVPlugin.h"
//#import "smartlinklib_7x.h"
#import "HFSmartLink.h"
#import "HFSmartLinkDeviceInfo.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface RNSmartLink : CDVPlugin {
    // Member variables go here.
    HFSmartLink * smtlk;
    BOOL isconnecting;
}

- (void) getSSID:(CDVInvokedUrlCommand*)command;
- (void)savePswd:(CDVInvokedUrlCommand*)command;
- (NSString *)getspwdByssid:(NSString * )mssid;
- (void)connect:(CDVInvokedUrlCommand*)command;

@end
  
