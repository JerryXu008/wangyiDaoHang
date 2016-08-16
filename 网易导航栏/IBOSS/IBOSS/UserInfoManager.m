//
//  UserInfoManager.m
//  TestRedCollar
//
//  Created by Hepburn Alex on 14-5-6.
//  Copyright (c) 2014年 Hepburn Alex. All rights reserved.
//

#import "UserInfoManager.h"
#import "sys/xattr.h"

static UserInfoManager *gUserManager = nil;

@implementation UserInfoManager

+ (UserInfoManager *)Share {
    if (!gUserManager) {
        gUserManager = [[UserInfoManager alloc] init];
    }
    return gUserManager;
}

- (BOOL)mbShowLoading {
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"showloading"];
    if (number) {
        return [number boolValue];
    }
    return YES;
}

- (void)setMbShowLoading:(BOOL)value {
    NSNumber *number = [NSNumber numberWithBool:value];
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:@"showloading"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mbLogin = NO;
    }
    return self;
}

#pragma mark - User Params

/*- (NSString *)mUserID {
    return [self GetUserValueforKey:@"UserID"];
}
- (void)setMUserID:(NSString *)value {
    [self SetUserValue:value forKey:@"UserID"];
}
- (NSString *)mUserName {
    return [self GetUserValueforKey:@"UserName"];
}
- (void)setMUserName:(NSString *)value {
    [self SetUserValue:value forKey:@"UserName"];
}*/


- (NSString *)mAccountID {
    return [self GetUserValueforKey:@"AccountID"];
}
- (void)setMAccountID:(NSString *)value {
    [self SetUserValue:value forKey:@"AccountID"];
}
- (NSString *)mStatus {
    return [self GetUserValueforKey:@"Status"];
}
- (void)setMStatus:(NSString *)value {
    [self SetUserValue:value forKey:@"Status"];
}
- (NSString *)mSessionKey {
    return [self GetUserValueforKey:@"SessionKey"];
}
- (void)setMSessionKey:(NSString *)value {
    [self SetUserValue:value forKey:@"SessionKey"];
}

- (NSString *)mRights {
    return [self GetUserValueforKey:@"Rights"];
}

- (void)setMRights:(NSString *)value {
    [self SetUserValue:value forKey:@"Rights"];
}

- (NSString *)mMessage {
    return [self GetUserValueforKey:@"Message"];
}

- (void)setMMessage:(NSString *)value {
    [self SetUserValue:value forKey:@"Message"];
}
- (void)setMAccountCode:(NSString *)value {
    if (value && value.length>0) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"AccountCode"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AccountCode"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)mAccountCode {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"AccountCode"];
}
- (void)setMUserCode:(NSString *)value {
    if (value && value.length>0) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"UserCode"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserCode"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)mUserCode {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UserCode"];
}

- (void)setMUserPwdOrinal:(NSString *)value {
    if (value && value.length>0) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"UserPwdOrinal"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserPwdOrinal"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)mUserPwdOrinal {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UserPwdOrinal"];
}


- (void)setMUserPwd:(NSString *)value {
    if (value && value.length>0) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"UserPwd"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserPwd"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)mUserPwd {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UserPwd"];
}

- (void)setMUserName:(NSString *)value {
    if (value && value.length>0) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"UserName"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserName"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)mUserName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
}

- (void)setMAutoLogin:(NSString *)value {
    if (value && value.length>0) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"AutoLogin"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AutoLogin"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)mAutoLogin {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"AutoLogin"];
}
- (void)setMServerUrl:(NSString *)value {
    if (value && value.length>0) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"ServerUrl"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ServerUrl"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)mServerUrl {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ServerUrl"];
}
- (void)setMServerPort:(NSString *)value {
    if (value && value.length>0) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"ServerPort"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ServerPort"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)mServerPort {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ServerPort"];
}

- (NSString *)mUserID {
    NSDictionary *dataDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"dataDic"];

    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
        NSDictionary *userinfo = [dataDic objectForKey:@"userinfo"];
        if (userinfo && [userinfo isKindOfClass:[NSDictionary class]]) {
            return [userinfo objectForKey:@"UserID"];
        }
    }
    return nil;
}

- (NSDictionary *)mUserData {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"dataDic"];
}

- (void)SetUserValue:(NSString *)value forKey:(NSString *)key {
    if (!value || !key) {
        return;
    }
   NSMutableDictionary *dataDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"dataDic"];
    
    
    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dataDic2 = [NSMutableDictionary dictionaryWithDictionary:dataDic];
        NSDictionary *userinfo = [dataDic2 objectForKey:@"userinfo"];
        if ([userinfo respondsToSelector:@selector(setObject:forKey:)]) {
            NSLog(@"NSMutableDictionary SetUserValue");
        }
        else {
            NSLog(@"NSDictionary SetUserValue");
        }
        
        if (userinfo && [userinfo isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *userinfo2 = [NSMutableDictionary dictionaryWithDictionary:userinfo];
            [userinfo2 setObject:value forKey:key];
            
            [dataDic2 setObject:userinfo2 forKey:@"userinfo"];
            [[NSUserDefaults standardUserDefaults] setObject:dataDic2 forKey:@"dataDic"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else {
            NSLog(@"SetUserValue Error:userinfo");
        }
    }
    else {
        NSLog(@"SetUserValue Error:dataDic");
    }
}

- (NSString *)GetUserValueforKey:(NSString *)key {
    NSDictionary *dataDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"dataDic"];
    
    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
        NSDictionary *userinfo = [dataDic objectForKey:@"userinfo"];
        if (userinfo && [userinfo isKindOfClass:[NSDictionary class]]) {
            return [userinfo objectForKey:key];
        }
    }
    return nil;
}

//清空保存数据
-(void)ClearUserData{
 NSDictionary *dataDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"dataDic"];
     dataDic=nil;
    [[NSUserDefaults standardUserDefaults]  setObject:dataDic forKey:@"dataDic"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
    
}


- (int)miTabIndex {
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"default"];
    if (number) {
        return [number intValue];
    }
    return 1;
}

- (void)setMiTabIndex:(int)value {
    NSNumber *number = [NSNumber numberWithBool:value];
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:@"default"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDate *)GetStartDate:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateString = [df stringFromDate:date];
    return [df dateFromString:dateString];
}

+ (NSString *)GetFormatDateString:(NSDate *)date {
    NSDate *startdate = [UserInfoManager GetStartDate:[NSDate date]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date toDate:startdate options:0];
    int year = [components year];
    int month = [components month];
    int day = [components day];
    int hour = [components hour];
    int minute = [components minute];
    int second = [components second];
    
    int iOffset = (hour*60+minute)*60+second;
    
    if (year == 0 && month == 0 && day < 2) {
        NSString *title = nil;
        if (day <= 0) {
            if (iOffset <= 0) {
                NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date toDate:[NSDate date] options:0];
                int hours = [components hour];
                int minutes = [components minute];
                if (hours == 0) {
                    return [NSString stringWithFormat:@"%d分钟前", minutes];
                }
                else if (hours <= 3) {
                    return [NSString stringWithFormat:@"%d小时前", hours];
                }
                else {
                    title = @"今天";
                }
            }
            else {
                title = @"昨天";
            }
        }
        else if (day == 1) {
            title = @"前天";
        }
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",title];
        return [df stringFromDate:date];
    }
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MM-dd HH:mm";
    return [df stringFromDate:date];
}

+ (NSString *)GetFormatDateByInterval:(NSTimeInterval)interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [UserInfoManager GetFormatDateString:date];
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

+ (void)AddiCloudBackUp {
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *libDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [UserInfoManager addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:docDir]];
    [UserInfoManager addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:libDir]];
}

@end
