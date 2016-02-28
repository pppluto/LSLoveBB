//
//  MatchDetailNewsCell.m
//  Just_Run
//
//  Created by aoyolo on 15/9/6.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MatchDetailNewsCell.h"
#import "UIImageView+WebCache.h"
#import "MatchDetailNewsModel.h"
@implementation MatchDetailNewsCell{
    
    __weak IBOutlet UIImageView *imgView;
    __weak IBOutlet UILabel *nameLabel;
}

- (void)awakeFromNib {
    imgView.layer.borderColor = MYRGB(230, 230, 230).CGColor;
    imgView.layer.borderWidth = 5;
    imgView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (UINib *)nib{
    return [UINib nibWithNibName:@"MatchDetailNewsCell" bundle:nil];
}
- (void)configureCellWithDictionary:(id)model{
    MatchDetailNewsModel *cellModel = (MatchDetailNewsModel *)model;
    [imgView sd_setImageWithURL:[NSURL URLWithString:cellModel.img]];
    nameLabel.text = cellModel.name;
    
}
@end
