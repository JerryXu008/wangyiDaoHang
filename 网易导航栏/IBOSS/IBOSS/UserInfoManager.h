//
//  UserInfoManager.h
//  TestRedCollar
//
//  Created by Hepburn Alex on 14-5-6.
//  Copyright (c) 2014年 Hepburn Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject {
    
}

@property (nonatomic, assign) BOOL mbLogin;
@property (nonatomic, assign) BOOL mbShowLoading;
@property (nonatomic, assign) int miTabIndex;

@property(nonatomic,assign)NSString * mStatus;
@property(assign)NSString * mMessage;
@property(assign) NSString *mAccountID;//帐套ID
@property (assign,readonly) NSString *mUserID;//用户ID
@property (nonatomic, assign) NSString *mUserName;
@property (nonatomic, assign) NSString *mRights;
@property(nonatomic,assign)NSString *mSessionKey;//GUID

@property (readonly) NSDictionary *mUserData;
@property(assign) NSString *mUserPwdOrinal;
@property(assign) NSString *mUserPwd;
@property(assign) NSString *mAccountCode;
@property(assign) NSString *mUserCode;
@property(assign) NSString *mAutoLogin;
//服务器地址和服务器端口
@property(assign) NSString *mServerUrl;
@property(assign) NSString *mServerPort;

+ (UserInfoManager *)Share;
+ (NSString *)GetFormatDateByInterval:(NSTimeInterval)interval;
+ (void)AddiCloudBackUp;

- (NSString *)GetUserValueforKey:(NSString *)key;
- (void)SetUserValue:(NSString *)value forKey:(NSString *)key;
-(void)ClearUserData;

#define kkStatus      [UserInfoManager Share].mStatus
#define kkMessage     [UserInfoManager Share].mMessage
#define kkAccountID   [UserInfoManager Share].mAccountID
#define kkUserID      [UserInfoManager Share].mUserID
#define kkUserName    [UserInfoManager Share].mUserName
#define kkRights      [UserInfoManager Share].mRights
#define kkSessionKey  [UserInfoManager Share].mSessionKey
#define kkUserData    [UserInfoManager Share].mUserData

#define kkUserPwdOrinal [UserInfoManager Share].mUserPwdOrinal
#define kkUserPwd     [UserInfoManager Share].mUserPwd
#define kkUserCode    [UserInfoManager Share].mUserCode
#define kkAccountCode [UserInfoManager Share].mAccountCode
#define kkAutoLogin   [UserInfoManager Share].mAutoLogin

#define kkServerUrl   [UserInfoManager Share].mServerUrl
#define kkServerPort   [UserInfoManager Share].mServerPort

@end
