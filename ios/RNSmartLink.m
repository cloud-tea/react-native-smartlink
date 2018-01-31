#import "RNSmartLink.h"

@implementation RNSmartLink

RCT_EXPORT_MODULE(SmartLink)
RCT_EXPORT_CORDOVA_METHOD(getSSID);
RCT_EXPORT_CORDOVA_METHOD(getspwdByssid);
RCT_EXPORT_CORDOVA_METHOD(connect);
RCT_EXPORT_CORDOVA_METHOD(savePswd);

- (void)pluginInitialize
{
    // Do any additional setup after loading the view, typically from a nib.
    smtlk = [HFSmartLink shareInstence];
    smtlk.isConfigOneDevice = true;
    smtlk.waitTimers = 30;
    isconnecting=false;
}


- (id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return info;
}

- (void) getSSID:(CDVInvokedUrlCommand*)command {
    BOOL wifiOK= FALSE;
    NSDictionary *ifs;
    NSString *ssid;
    CDVPluginResult* pluginResult = nil;
    
    if (!wifiOK)
    {
        ifs = [self fetchSSIDInfo];
        ssid = [ifs objectForKey:@"SSID"];
        
        NSLog(@"SSID是： %@", ssid);
        
        if (ssid!= nil)
        {
            wifiOK= TRUE;
            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:ssid];
            
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
    }
    
}


- (void)savePswd:(CDVInvokedUrlCommand*)command {
    NSDictionary *params = [command.arguments objectAtIndex:0];
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setObject:[params objectForKey:@"wifiPass"] forKey:[params objectForKey:@"wifiName"]];
}

- (NSString *)getspwdByssid:(NSString * )mssid{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:mssid];
}

- (void)connect:(CDVInvokedUrlCommand*)command {
    NSDictionary *params = [command.arguments objectAtIndex:0];
    NSString * ssidStr= [params objectForKey:@"wifiName"];
    NSString * pswdStr = [params objectForKey:@"wifiPass"];
    
    
    if(!isconnecting){
        isconnecting = true;
        
        // Check command.arguments here.
        [self.commandDelegate runInBackground:^{
            [smtlk startWithSSID:ssidStr Key:pswdStr withV3x:true
                    processblock: ^(NSInteger pro) {
                        // todo: in progress
                    } successBlock:^(HFSmartLinkDeviceInfo *dev) {
                        CDVPluginResult* pluginResult = [CDVPluginResult
                                                         resultWithStatus: CDVCommandStatus_OK
                                                         messageAsString: [NSString stringWithFormat:@"%@$%@",dev.mac,dev.ip]
                                                         ];
                        
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                    } failBlock:^(NSString *failmsg) {
                        
                        CDVPluginResult* pluginResult = [CDVPluginResult
                                                         resultWithStatus: CDVCommandStatus_ERROR
                                                         messageAsString: [NSString stringWithFormat:@"%@", failmsg]
                                                         ];
                        
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                        
                    } endBlock:^(NSDictionary *deviceDic) {
                        isconnecting  = false;
                    }];
        }];
    }else{
        [smtlk stopWithBlock:^(NSString *stopMsg, BOOL isOk) {
            if(isOk){
                isconnecting  = false;
                [self showAlertWithMsg:stopMsg title:@"Stopped OK"];
            }else{
                [self showAlertWithMsg:stopMsg title:@"Stop with error"];
            }
        }];
    }
    
}


-(void)showAlertWithMsg:(NSString *)msg
                  title:(NSString*)title{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alert show];
}

@end
  
