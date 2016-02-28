//
//  RecommendCourtView.m
//  Just_Run
//
//  Created by aoyolo on 15/9/2.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "RecommendCourtView.h"
#import "CourtModel.h"
#import "UIImageView+WebCache.h"

@implementation RecommendCourtView{
    UIImageView *imgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imgView];
    }
    return self;
}
- (void)configureViewWithModel:(CourtModel *)model{
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat height = [UIImage imageHeightBaseOnWidth:image width:WIDTH];
        self.bounds = CGRectMake(0, 0, WIDTH, height);
    }];
}
@end
