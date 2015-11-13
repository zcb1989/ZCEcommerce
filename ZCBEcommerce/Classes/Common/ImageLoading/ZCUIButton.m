//
//  ZCUIButton.m
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/13.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#import "ZCUIButton.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "EGOPlaceholder.h"

@implementation ZCUIButton

@synthesize imageURL = _imageURL;

+ (instancetype)captchaView
{
    ZCUIButton *btn = [[self alloc] init];
    btn.cacheOptions = (SDWebImageRetryFailed|SDWebImageRefreshCached|SDWebImageContinueInBackground|SDWebImageHandleCookies|SDWebImageHighPriority);
    return btn;
}

- (void)dealloc
{
    [self sd_cancelImageLoadForState:UIControlStateNormal];
}

- (void)setUp
{
    self.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder"];
    self.shouldShowIndicator = YES;
    self.cacheOptions = (SDWebImageRetryFailed|SDWebImageContinueInBackground);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType
{
    id btn = [super buttonWithType:buttonType];
    [btn setUp];
    return btn;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (void)setRefreshCached:(BOOL)refreshCached
{
    _refreshCached = refreshCached;
    if (_refreshCached) {
        self.cacheOptions |= SDWebImageRefreshCached;
    } else {
        self.cacheOptions &= (0xffff ^ SDWebImageRefreshCached);
    }
}

- (void)setImageURL:(NSURL *)imageURL
{
    if (_imageURL != imageURL) {
        _imageURL = imageURL;
        
        if (self.shouldShowIndicator) [self.indicatorView startAnimating];
        
        @weakify(self);
        [self sd_setImageWithURL:_imageURL forState:UIControlStateNormal placeholderImage:self.placeholderImage options:self.cacheOptions completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            @strongify(self);
            if (self.shouldShowIndicator) [self.indicatorView stopAnimating];
            
            if (image)
            {
                if ([self.delegate respondsToSelector:@selector(imageButtonLoadedImage:)]) {
                    [self.delegate imageButtonLoadedImage:self];
                }
            }
            else
            {
                ZCLogError(@"ImageLoadError: %@", error);
                if ([self.delegate respondsToSelector:@selector(imageButtonFailedToLoadImage:error:)]) {
                    [self.delegate imageButtonFailedToLoadImage:self error:error];
                }
            }
        }];
        
    } else if (imageURL == nil) {
        
        [self setImage:self.placeholderImage forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    if (!CGSizeEqualToSize(self.frame.size, frame.size))
    {
        _adjustedPlaceholder = nil;
    }
    [super setFrame:frame];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    if (image == self.placeholderImage)
    {
        if (!_adjustedPlaceholder) {
            _adjustedPlaceholder = [EGOPlaceholder adjustPlaceholderImage:image size:self.frame.size];
        }
        image = _adjustedPlaceholder;
    }
    //    [super setImage:image forState:state];
    [super setBackgroundImage:image forState:state];
}

- (void)addLeftLine{
    //left
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.frame.size.height)];
    leftImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:leftImageView];
    ZC_RELEASE_SAFELY(leftImageView);
}

- (void)addBottomLine{
    //bottom
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    bottomImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:bottomImageView];
    ZC_RELEASE_SAFELY(bottomImageView);
}

- (void)addTopLine{
    //top
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    topImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:topImageView];
    ZC_RELEASE_SAFELY(topImageView);
}

- (void)addTopRightBottomLine {
    //top
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    topImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:topImageView];
    ZC_RELEASE_SAFELY(topImageView);
    
    //right
    UIImageView *verticalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
    verticalImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:verticalImageView];
    ZC_RELEASE_SAFELY(verticalImageView);
    
    //bottom
    UIImageView *horizonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    horizonImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:horizonImageView];
    ZC_RELEASE_SAFELY(horizonImageView);
}

- (void)addRightBottomLine {
    //bottom
    UIImageView *horizonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    horizonImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:horizonImageView];
    ZC_RELEASE_SAFELY(horizonImageView);
    
    //right
    UIImageView *verticalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
    verticalImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:verticalImageView];
    ZC_RELEASE_SAFELY(verticalImageView);
}

- (void)addFullLine {
    
    //top
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    topImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:topImageView];
    ZC_RELEASE_SAFELY(topImageView);
    
    //right
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
    rightImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:rightImageView];
    ZC_RELEASE_SAFELY(rightImageView);
    
    //bottom
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    bottomImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:bottomImageView];
    ZC_RELEASE_SAFELY(bottomImageView);
    
    //left
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.frame.size.height)];
    leftImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:leftImageView];
    ZC_RELEASE_SAFELY(leftImageView);
}

- (void)addBottomLineRightOffset{
    //bottom
    UIImageView *horizonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width-5, 0.5)];
    horizonImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:horizonImageView];
    ZC_RELEASE_SAFELY(horizonImageView);
}

- (void)addRightBottomLineLeftOffset{
    //right
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
    rightImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:rightImageView];
    ZC_RELEASE_SAFELY(rightImageView);
    
    //bottom
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    bottomImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:bottomImageView];
    ZC_RELEASE_SAFELY(bottomImageView);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
