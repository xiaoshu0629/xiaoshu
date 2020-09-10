
#import <UIKit/UIKit.h>

#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

UIKIT_EXTERN NSString *const NetworkStatusMonitorNotification;
UIKIT_EXTERN NSString *const NetworkStatusString;

@interface NetWorkReachability : NSObject

+ (instancetype)share;

@property (nonatomic, assign) BOOL           isConnection;

@property (nonatomic, assign) NSInteger      connecteStatus;

@property (nonatomic, strong) NSString       *connecteStatusString;

@property (nonatomic, strong) NSString       *connectOperator;

@property (nonatomic, strong) NSString       *connecteStatusString2;

@property (nonatomic, strong) CTCarrier      *connecteCarrier;

@end
