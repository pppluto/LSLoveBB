//
//  MatchCell.m
//  Just_Run
//
//  Created by aoyolo on 15/8/30.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MatchCell.h"
#import "UIImageView+WebCache.h"
#import "MatchModel.h"
@implementation MatchCell{
    
    __weak IBOutlet UIImageView *imgView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *stadiumLabel;
    __weak IBOutlet UILabel *provinceLabel;
}
+ (UINib *)nib{
    return [UINib nibWithNibName:@"MatchCell" bundle:nil];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithDictionary:(MatchModel *)model{
    MatchModel *matchModel = (MatchModel *)model;
    [imgView sd_setImageWithURL:[NSURL URLWithString:matchModel.img]];
    nameLabel.text = matchModel.name;
    stadiumLabel.text = matchModel.areaDetail;
    provinceLabel.text = matchModel.province;
}
@end
