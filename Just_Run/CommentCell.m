//
//  CommentCell.m
//  Just_Run
//
//  Created by aoyolo on 15/9/5.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "Helper.h"
@implementation CommentCell{
    
    __weak IBOutlet UIImageView *userImg;
    __weak IBOutlet UILabel *userAndReplyLabel;
    __weak IBOutlet UILabel *leaveContentLabel;
    __weak IBOutlet UILabel *timeLabel;
}
+ (UINib *)nib{
    return [UINib nibWithNibName:@"CommentCell" bundle:nil];
}
- (void)awakeFromNib {
    // Initialization code
    userImg.layer.cornerRadius = 30;
    userImg.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithDictionary:(id)model{
    CommentModel *commentModel = (CommentModel *)model;
    [userImg sd_setImageWithURL:[NSURL URLWithString:commentModel.userImg]];
    if (commentModel.replyUserName!=nil) {
        userAndReplyLabel.attributedText = [Helper combineUserName:commentModel.userName replyName:commentModel.replyUserName];
    } else {
        userAndReplyLabel.text = commentModel.userName;
    }
    leaveContentLabel.text = commentModel.leave_content;
    timeLabel.text = commentModel.add_time;
    
}
@end
