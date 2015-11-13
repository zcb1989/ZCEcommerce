//
//  ZCUIImageView.h
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/13.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EGOImageViewDelegate;
@protocol ZCImageLoadOperation;
/**
 *  配置的初始化方法
 */
ZC_EXTERN void ZCImageCacheConfig(void);
/**
 *  清空图片缓存
 *
 *  @param completion 清除完成的回调
 */
ZC_EXTERN void ZCImageCacheClearWithCompletion(dispatch_block_t completion);
/**
 *  预加载图片
 *
 *  @param urls 图片url数组
 */
ZC_EXTERN void ZCImageCachePreloadImages(NSArray *urls);
/**
 *  从网络缓存中获取图片
 *
 *  @param url         图片url
 *  @param ^completion 获取的图片
 *
 */
ZC_EXTERN id <ZCImageLoadOperation> ZCImageLoadImage(NSURL *url,void(^completion)(UIImage *image));
/**
 *  清空内存缓存
 */
ZC_EXTERN void ZCImageCacheClearMemory(void);


@interface ZCUIImageView : UIImageView{
    NSURL       *_imageURL;
    UIImage     *_placeholder;
    UIImage     *_adjustedPlaceholder;
}
/**
 *  imageURL
 */
@property (nonatomic,strong) NSURL *imageURL;
/**
 *  placeholder
 */
@property (nonatomic,strong) UIImage *placeholderImage;
/**
 *  ImageOptions,
 */
@property (nonatomic,assign) NSUInteger cacheOptions;
/**
 *  Loading框
 */
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
/**
 *  是否显示加载中
 */
@property (nonatomic,assign) BOOL shouldShowIndicator;
/**
 *  设置为YES时，cache由NSURLCache管理
 */
@property (nonatomic,assign) BOOL refreshCached;
/**
 *  点击事件
 */
@property (nonatomic,copy) void (^touchEndBlock)(ZCUIImageView *imgView);

@property (nonatomic,strong) UIImageView *topLineImage;
@property (nonatomic,strong) UIImageView *rightLineImage;
@property (nonatomic,strong) UIImageView *bottomLineImage;
@property (nonatomic,strong) UIImageView *leftLineImage;
/**
 *  为验证码图片定制的view
 *
 */
+ (instancetype)captchaView;

@property (nonatomic,weak) id<EGOImageViewDelegate> delegate;
/**
 *  为图片的右边和底边添加一条线
 */
- (void)addRightBottomLine;
/**
 *  为图片的顶部、右侧、底部划线，适合于每个模块的最顶部的图片
 */
- (void)addTopRightBottomLine;
/**
 *  4个边都添加线
 */
- (void)addFullLine;
@end

#pragma mark - 以下为了兼容EGOImage

#define EGOImageView ZCUIImageView

@protocol EGOImageViewDelegate <NSObject>

@optional
- (void)imageViewLoadedImage:(EGOImageView *)imageView;
- (void)imageViewFailedToLoadImage:(EGOImageView *)imageView error:(NSError *)error;
@end

@class EGOImageViewEx;
@protocol EGOImageViewExDelegate <NSObject>
@optional
- (void)imageExViewDidOK:(EGOImageViewEx *)imageViewEx;

@end

@interface EGOImageViewEx : ZCUIImageView
@property (nonatomic,weak) id<EGOImageViewExDelegate> exDelegate;

@end

@protocol ZCImageLoadOperation <NSObject>

- (void)cancel;

@end
