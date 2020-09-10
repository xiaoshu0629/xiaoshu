
#import "NetWorkReachability.h"
#import "AFNetworkReachabilityManager.h"

static NetWorkReachability *reachability = nil;

NSString *const NetworkStatusMonitorNotification = @"NetworkStatusMonitorNotification";
NSString *const NetworkStatusString = @"NetworkStatusString";
static NSString *StringFromNetworkReachabilityStatus(AFNetworkReachabilityStatus status) {
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            return @"notReachable";
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return @"wwan";
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return @"wifi";
        case AFNetworkReachabilityStatusUnknown:
        default:
            return @"unKnown";
    }
}

@implementation NetWorkReachability

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)share
{
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        reachability = [[NetWorkReachability alloc] init];
    });

    return reachability;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.isConnection = YES;
        self.connecteStatus = 0;
        self.connecteStatusString = @"";

        [[AFNetworkReachabilityManager sharedManager] startMonitoring];

        __weak __typeof(self)weakSelf = self;
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;

            strongSelf.isConnection = (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi);
            strongSelf.connecteStatus = status;
            strongSelf.connecteStatusString = StringFromNetworkReachabilityStatus(status);
            [[NSNotificationCenter defaultCenter] postNotificationName:NetworkStatusMonitorNotification object:strongSelf userInfo:@{NetworkStatusString : strongSelf.connecteStatusString}];

            if (status == AFNetworkReachabilityStatusReachableViaWWAN) {

                NSString *netconnType = nil;

                CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];

                NSString *currentStatus = info.currentRadioAccessTechnology;

                if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                    netconnType = @"GPRS";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                    netconnType = @"2.75G EDGE";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]) {
                    netconnType = @"3G";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]) {
                    netconnType = @"3.5G HSDPA";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]) {
                    netconnType = @"3.5G HSUPA";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]) {
                    netconnType = @"2G";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]) {
                    netconnType = @"3G";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]) {
                    netconnType = @"3G";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]) {
                    netconnType = @"3G";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]) {
                    netconnType = @"HRPD";
                } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]) {
                    netconnType = @"4G";
                }

                if (netconnType) {
                    strongSelf.connecteStatusString = netconnType;
                }

                strongSelf.connecteCarrier = info.subscriberCellularProvider;

                if (strongSelf.connecteCarrier.isoCountryCode) {
                    strongSelf.connectOperator = strongSelf.connecteCarrier.carrierName;
                }
            }
        }];
    }

    return self;
}

- (NSString *)connecteStatusString2
{
    if (self.connecteStatus == AFNetworkReachabilityStatusNotReachable) {
        return @"";
    } else if (self.connecteStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        return [NSString stringWithFormat:@"%@,%@", self.connecteStatusString, self.connectOperator];
    } else if (self.connecteStatus == AFNetworkReachabilityStatusReachableViaWiFi) {
        return @"wifi";
    } else {
        return @"";
    }
}

@end
