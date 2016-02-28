//
//  CourtCell.m
//  Just_Run
//
//  Created by aoyolo on 15/8/30.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "CourtCell.h"
#import "CourtModel.h"
#import "UIImageView+WebCache.h"
@implementation CourtCell{
    
    __weak IBOutlet UIImageView *imgView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *areaDetail;
    __weak IBOutlet UILabel *area;
}
+ (UINib *)nib{
    return [UINib nibWithNibName:@"CourtCell" bundle:nil];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithDictionary:(id)model{
    CourtModel *courtModel = (CourtModel *)model;
    [imgView sd_setImageWithURL:[NSURL URLWithString:courtModel.img]];
    area.text = courtModel.area;
    nameLabel.text = courtModel.name;
    areaDetail.text = courtModel.areaDetail;
}
@end
