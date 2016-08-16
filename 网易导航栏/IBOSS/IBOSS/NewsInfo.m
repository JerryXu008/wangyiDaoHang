//
//  NewsInfo.m
//  掌上社区
//
//  Created by Hepburn Alex on 14-2-21.
//  Copyright (c) 2014年 iHope. All rights reserved.
//

#import "NewsInfo.h"
#import "MBProgressHUD.h"
@implementation NewsInfo
#define MDict (@"mDict")
#define M_abstract (@"m_abstract")
#define M_image (@"m_image")
#define M_newsid (@"m_newsid")
#define M_title (@"m_title")
#define M_time (@"m_time")
#define M_source (@"m_source")
#define M_url (@"m_url")

- (void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.mDict forKey:MDict];
    [coder encodeObject:self.m_abstract forKey:M_abstract];
    [coder encodeObject:self.m_image forKey:M_image];
    [coder encodeObject:self.m_newsid forKey:M_newsid];
    [coder encodeObject:self.m_title forKey:M_title];
    [coder encodeObject:self.m_time forKey:M_time];
    [coder encodeObject:self.m_source forKey:M_source];
    [coder encodeObject:self.m_audio forKey:@"audio"];

    [coder encodeObject:self.m_url forKey:M_url];
}

- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init])
    {
        if (decoder == nil)
        {
            return self;
        }
        self.mDict = [decoder decodeObjectForKey:MDict];
        self.m_abstract = [decoder decodeObjectForKey:M_abstract];
        self.m_image = [decoder decodeObjectForKey:M_image];
        self.m_newsid = [decoder decodeObjectForKey:M_newsid];
        self.m_title = [decoder decodeObjectForKey:M_title];
        self.m_time = [decoder decodeObjectForKey:M_time];
        self.m_source = [decoder decodeObjectForKey:M_source];
        self.m_audio = [decoder decodeObjectForKey:@"audio"];
        self.m_url = [decoder decodeObjectForKey:M_url];
        
    }
    return self;
}

+ (NewsInfo *)CreateWithDict:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [[NewsInfo alloc] initWithDict:dict];
}

- (NSDictionary *)GetFormatDict:(NSDictionary *)dict1 {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dict1];
    for (NSString *key in dict.allKeys) {
        id target = [dict objectForKey:key];
        if ([target isKindOfClass:[NSNull class]]) {
            [dict removeObjectForKey:key];
        }
    }
    return dict;
}

- (id)initWithDict:(NSDictionary *)dict1 {
    self = [super init];
    if (self) {
        NSDictionary *dict = [self GetFormatDict:dict1];
        self.mDict = dict;
        self.m_abstract = [dict objectForKey:@"abstract"];
        self.m_image = [dict objectForKey:@"image"];
        self.m_newsid = [dict objectForKey:@"newsid"];
        self.m_title = [dict objectForKey:@"title"];
        self.m_time = [dict objectForKey:@"time"];
        self.m_source = [dict objectForKey:@"source"];
        self.m_audio = [dict objectForKey:@"audio"];
        if (self.m_audio) {
            if ([self.m_audio isEqualToString:@"null"]) {
                self.m_audio = nil;
            }
            else {
                self.m_audio = [self.m_audio stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
        }
        self.m_url = [dict objectForKey:@"url"];
    }
    return self;
}
/*+(BOOL)IsCollected:(NewsInfo *)info
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:NewsInfoCollection];
    if([fileMgr fileExistsAtPath:filePath] )
    {
        NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
        BOOL isext=NO;
        for(int i=0;i<arr.count;i++)
        {
            NewsInfo *info2=[arr objectAtIndex:i];
            
            if([info2.m_url isEqualToString:info.m_url])
            {
                isext=YES;
                break;
            }
        }
        if(!isext)
        {
            return NO;
        }
        else
        {
            return YES;
            
        }
 
    }
    else return NO;

}*/
/*+(BOOL) NewsInfoCollect: (NewsInfo *)info andView:(UIView *)view
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view] ;
    [view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:nil];
    HUD.mode = MBProgressHUDModeCustomView;
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:NewsInfoCollection];
    NSLog(@"filepath=%@",filePath);
    BOOL success=NO;
    if([fileMgr fileExistsAtPath:filePath] )
    {
        
        NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
        BOOL isext=NO;
        for(int i=0;i<arr.count;i++)
        {
            NewsInfo *info2=[arr objectAtIndex:i];
            
            if([info2.m_url isEqualToString:info.m_url])
            {
                isext=YES;
                break;
            }
        }
        if(!isext)
        {
            [arr addObject:info];
            success= [NSKeyedArchiver archiveRootObject:arr toFile:filePath];
            if(success){
                HUD.labelText = @"收藏成功!";
                [HUD show:YES];
                [HUD hide:YES afterDelay:1];
            }
            
        }
        else
        {
            HUD.labelText = @"已经收藏过!";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            success=YES;
            
        }
        
    }
    else //不存在
    {
        NSMutableArray *mularr=[[NSMutableArray alloc] initWithCapacity:1];
        [mularr addObject:info];
        success= [NSKeyedArchiver archiveRootObject:mularr toFile:filePath];
        if(success){
            HUD.labelText = @"收藏成功!";
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
        }
        
    }
    if(success==NO)
    {
        HUD.labelText = @"收藏失败!";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    return success;
}

+(NSMutableArray *)DeleteHistory:( NewsInfo *)info andView:(UIView *)view
{
    
    NSMutableArray *tempArr=[[NSMutableArray alloc] init];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:NewsInfoCollection];
    if([fileMgr fileExistsAtPath:filePath] )
    {
        NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
        for(int i=0;i<arr.count;i++)
        {
            NewsInfo *tempInfo=[arr objectAtIndex:i];
            if(![tempInfo.m_url isEqualToString:info.m_url])
            {
                [tempArr addObject:tempInfo];
            }
        }
        [ NSKeyedArchiver archiveRootObject:tempArr toFile:filePath];
        
    }
    else
    {
        // HUD.labelText = @"取消收藏失败!";
        //[HUD show:YES];
        //[HUD hide:YES afterDelay:1];
        
    }
    
    
    
    return tempArr;
    
}
+(NSMutableArray *)HistoryBackList
{
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:NewsInfoCollection];
    if([fileMgr fileExistsAtPath:filePath] )
    {
        NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
        if(arr==nil||arr.count==0)
        {
            return nil;
        }
        else return arr;
    }
    else
    {
        return nil;
    }
    
}
*/
- (void)dealloc {
    self.mDict = nil;
    self.m_abstract = nil;
    self.m_image = nil;
    self.m_newsid = nil;
    self.m_title = nil;
    self.m_time = nil;
    self.m_source = nil;
    self.m_audio = nil;
    self.m_url = nil;
}

@end
