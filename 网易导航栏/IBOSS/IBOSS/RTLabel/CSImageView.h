//
//  CSImageView.h
//  So Amusing
//

//  響應點擊事件的ImageView，用於「點擊頭像進入個人詳情」、「點擊圖片查看大圖」

//  Created by ihope999 on 13-8-14.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TImageType_FullFillCS,
    TImageType_CutFillCS,
    TImageType_AutoSizeCS,
    TImageType_LeftAlignCS,
    TImageType_TopAlignCS
}TImageTypeCS;

typedef void(^ImageBlock)(void);

@interface CSImageView : UIImageView
{
    UIActivityIndicatorView *mActView;
    NSURLConnection *mConnection;
    NSMutableData *mWebData;
    TImageTypeCS mImageType;
    BOOL mbLoading;
    UIImageView *mImageView;
}
@property (copy, nonatomic) ImageBlock touchBlock;



//
@property (nonatomic, retain) id userinfo;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL OnImageLoad;
@property (nonatomic, assign) BOOL mbActShow;
@property (nonatomic, assign) TImageTypeCS mImageType;
@property (readonly, assign) BOOL mbLoading;
@property (nonatomic, retain) NSString *mLocalPath;
@property (nonatomic, assign) UIImageView *mImageView;
@property (nonatomic, retain) NSString *mDefaultPath;

- (void)GetImageByStr:(NSString *)path;
- (void)Cancel;
- (BOOL)ShowLocalImage;
- (void)ShowLocalImage:(NSString *)imagename;

+ (NSString *)GetLocalPathOfUrl:(NSString *)path;
+ (NSString *)MD5String:(NSString *)str;

@end
