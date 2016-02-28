//
//  NearbyViewController.m
//  Just_Run
//
//  Created by aoyolo on 15/8/26.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "NearbyViewController.h"
#import "DetailsController.h"

#define MAPKEY @"66116726c85ab07dfc37c0d7df7e3d13"

@interface NearbyViewController () <UITableViewDelegate>
{
    NSDictionary *_allAreasDict;
    NSDictionary *_allCityDict;
    NSDictionary *_allCitysArray;
    UIButton *_rightButtonItem;
}
@end

@implementation NearbyViewController
#pragma mark Event cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据点击弹出子视图。
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark Private methods
- (void)setUp{
    self.title = @"发现";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:TopicFont(20)};
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    [self makeCustomeRightButtonView];
    self.navigationController.navigationBar.barTintColor = TopicColor;
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:_rightButtonItem];
    self.navigationItem.rightBarButtonItem = right;
    _allAreasDict = [[NSDictionary alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"area" withExtension:@"plist"]];
    _allCityDict = [[NSDictionary alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"citydict" withExtension:@"plist"]];
    _allCitysArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"citys.txt" withExtension:nil]] options:NSJSONReadingAllowFragments error:nil];

}
- (void)makeCustomeRightButtonView{
    _rightButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButtonItem.frame = CGRectMake(0, 0, 100, 40);
    [_rightButtonItem setTitle:@"深圳" forState:UIControlStateNormal];
    _rightButtonItem.titleLabel.font = TopicFont(15);
    [_rightButtonItem addTarget:self action:@selector(locationChangeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_rightButtonItem setImage:[UIImage imageNamed:@"arrow-down"] forState:UIControlStateNormal];
}
#pragma mark  Event response
- (void)locationChangeButtonClicked{
    DetailsController *details = [[DetailsController alloc] init];
    details.placesDict = [_allCityDict copy];
    details.block = ^(NSString *str){
        [_rightButtonItem setTitle:[str substringToIndex:str.length-1] forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:details animated:YES];
}





@end
