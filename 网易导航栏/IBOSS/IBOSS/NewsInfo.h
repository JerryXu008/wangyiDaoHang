//
//  NewsInfo.h
//  掌上社区
//
//  Created by Hepburn Alex on 14-2-21.
//  Copyright (c) 2014年 iHope. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MDict (@"mDict")
#define M_abstract (@"m_abstract")
#define M_image (@"m_image")
#define M_newsid (@"m_newsid")
#define M_title (@"m_title")
#define M_time (@"m_time")
#define M_source (@"m_source")
#define M_url (@"m_url")
@interface NewsInfo : NSObject<NSCoding> {
    
}

@property (nonatomic, strong) NSDictionary *mDict;
@property (nonatomic, strong) NSString *m_abstract;
@property (nonatomic, strong) NSString *m_image;
@property (nonatomic, strong) NSString *m_newsid;
@property (nonatomic, strong) NSString *m_title;
@property (nonatomic, strong) NSString *m_time;
@property (nonatomic, strong) NSString *m_source;
@property (nonatomic, strong) NSString *m_audio;
@property (nonatomic, strong) NSString *m_url;


+ (NewsInfo *)CreateWithDict:(NSDictionary *)dict;
- (id)initWithDict:(NSDictionary *)dict;
+(BOOL) NewsInfoCollect: (NewsInfo *)info andView:(UIView *)view;
+(NSMutableArray *)DeleteHistory:( NewsInfo *)info andView:(UIView *)view;
+(NSMutableArray *)HistoryBackList;
+(BOOL)IsCollected:(NewsInfo *)info;
@end
