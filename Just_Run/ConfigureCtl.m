//
//  ConfigureCtl.m
//  Just_Run
//
//  Created by aoyolo on 15/9/8.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "ConfigureCtl.h"
#import "SDImageCache.h"
@interface ConfigureCtl ()
{
    CAGradientLayer *_gradientLayer;
    UIView *_progressView;
}
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation ConfigureCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger cache = [[SDImageCache sharedImageCache] getSize];
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",(float)cache/1024/1024];
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(20, 170, WIDTH-40, 20)];
    _progressView.layer.cornerRadius = 10;
    _progressView.opaque = NO;
    _progressView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_progressView];
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.colors = @[(id)[UIColor greenColor].CGColor,(id)[UIColor redColor].CGColor];
    _gradientLayer.startPoint = CGPointMake(0, 1);
    _gradientLayer.endPoint = CGPointMake(1, 0);
    _gradientLayer.frame = _progressView.frame;
    _gradientLayer.mask = _progressView.layer;
    _progressView.frame = _gradientLayer.bounds;
    [self.view.layer addSublayer:_gradientLayer];

}
- (IBAction)backButtonClicked:(UIButton *)sender {
    [self.delegate dismissConfigureCtl];
}
- (IBAction)clearButtonClicked:(UIButton *)sender {
    [[SDImageCache sharedImageCache] clearDisk];
    NSInteger cache = [[SDImageCache sharedImageCache] getSize];
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",(float)cache/1024/1024];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end





