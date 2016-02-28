//
//  FocusCell.m
//  Just_Run
//
//  Created by aoyolo on 15/8/29.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "FocusCell.h"
#import "UIImageView+WebCache.h"
@interface FocusCell()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *decorationView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *postTime;
@property (weak, nonatomic) IBOutlet UILabel *describle;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton * videoPlayButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgbackViewContraintH;
@end
@implementation FocusCell
+ (UINib *)nib{
    return [UINib nibWithNibName:@"FocusCell" bundle:nil];
}
- (void)awakeFromNib {
//    self.contentView.layer.cornerRadius = 10;
//    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.contentView.layer.borderWidth = 5;
    _userIcon.layer.cornerRadius = 30;
    _userIcon.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleToFill;
    _imgView.layer.cornerRadius = 10;
    _imgView.clipsToBounds = YES;
    _decorationView.layer.cornerRadius = 10;
    _decorationView.clipsToBounds = YES;
    _commentButton.layer.cornerRadius = 5;
    _shareButton.layer.cornerRadius = 5;
    _likeButton.layer.cornerRadius = 5;
    _moreButton.layer.cornerRadius = 5;
    _videoPlayButton.hidden = YES;
    [_likeButton addTarget:self.cellDelegate action:@selector(cellLikeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_shareButton addTarget:self.cellDelegate action:@selector(cellShareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_moreButton addTarget:self.cellDelegate action:@selector(cellMoreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_videoPlayButton addTarget:self.cellDelegate action:@selector(cellVideoPlayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCellWithDictionary:(id)model{
    FocusModel *focusModel = (FocusModel *)model;
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:focusModel.userIcon]];
    _userName.text = focusModel.userName;
    _postTime.text = focusModel.postTime;
    _describle.text = focusModel.describle;
    _videoPlayButton.hidden = ([focusModel.dynamicVideo hasSuffix:@".com/"] || (focusModel.dynamicVideo.length<5));
    NSInteger dynamicID = [focusModel.dynamicID integerValue];
    _shareButton.tag = dynamicID;
    _moreButton.tag = dynamicID;
    _likeButton.tag = dynamicID;
    _videoPlayButton.tag = dynamicID;
    _likeButton.selected = focusModel.isLiked;
    [_likeButton setTitle:focusModel.likeCount forState:UIControlStateNormal];
    [_commentButton setTitle:focusModel.leaveCount forState:UIControlStateNormal];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:focusModel.dynamicImg]
                                  placeholderImage:nil
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            CGSize size = image.size;
                            CGFloat height = size.height*self.frame.size.width/size.width;
                           _imgbackViewContraintH.constant = height + 16;
                           [self.superview setNeedsDisplay];
                            focusModel.imgHeight = height;
    }];
}

@end
