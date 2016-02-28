//
//  MapViewCtl.m
//  Just_Run
//
//  Created by aoyolo on 15/9/3.
//  Copyright (c) 2015年 aoyolo. All rights reserved.
//

#import "MapViewCtl.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CourtModel.h"
@interface MapViewCtl () <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocation *_currentLocation;
    CLLocation *_courtLocation;
    MKPlacemark *_clpk;
    MKPlacemark *_currentPlaceMark;
    
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewCtl
- (void)navigateButtonClicked:(UIButton *)sender {
    [_geocoder geocodeAddressString:[NSString stringWithFormat:@"%@%@%@",self.model.area,self.model.areaDetail,self.model.name] completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"error");
        } else {
            _clpk = placemarks[0];
            NSLog(@"%@",_clpk.name);
            CLLocation *loc = _clpk.location;
            MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
            anno.coordinate = loc.coordinate;
            [_mapView addAnnotation:anno];
            [self navigateCourt];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUp{
    
    _mapView.mapType = MKMapTypeStandard;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.delegate = self;
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"导航" style:UIBarButtonItemStylePlain target:self action:@selector(navigateButtonClicked:)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    _geocoder = [[CLGeocoder alloc] init];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
}
/**
 *  授权状态发生改变时调用
 *
 *  @param manager 触发事件的对象
 *  @param status  当前授权的状态
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待用户授权");
    }else if (status == kCLAuthorizationStatusAuthorizedAlways ||
              status == kCLAuthorizationStatusAuthorizedWhenInUse)
        
    {
        NSLog(@"授权成功");
        // 开始定位
        [_locationManager startUpdatingLocation];
        
    }else
    {
        NSLog(@"授权失败");
    }
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"updateUserLocation");
    [_geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        _currentPlaceMark = [placemarks firstObject];
        userLocation.title = _currentPlaceMark.name;
        userLocation.subtitle = _currentPlaceMark.locality;
    }];
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [_mapView setRegion:region animated:YES];
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"region did");
}
#pragma mark   addOverlay方法触发
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    //创建单线渲染对象
    MKPolylineRenderer *polyLineRender = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    //设置折现属性
    polyLineRender.lineCap = kCGLineCapRound;
    polyLineRender.lineWidth = 5;
    polyLineRender.strokeColor = [UIColor greenColor];
    return polyLineRender;
}
#pragma mark 导航路线
- (void)navigateCourt {
    //1 创建导航请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    //2 导航交通方式                    代步车路线 步行路线。。。
    request.transportType = MKDirectionsTransportTypeAutomobile;
    //3 指定起点终点
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithPlacemark:_clpk]];
    //4 创建导航对象
    MKDirections *dirctions = [[MKDirections alloc] initWithRequest:request];
    [dirctions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            //取得导航路线对象
            MKRoute *route = response.routes[0];
            //该方法将触发正真划线的方法   mapview: rendererForOverlay:
            [_mapView addOverlay:route.polyline level:MKOverlayLevelAboveLabels];
        }
    }];
}

#pragma mark MapKit代理
//addAnnotation方法时会调用
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if (_mapView.userLocation == annotation) {
        return nil;
    }
    static NSString *identifier = @"anno";
    MKAnnotationView *annoView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annoView == nil) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        //        annoView.pinColor = MKPinAnnotationColorPurple;
        //动画效果
        //annoView.animatesDrop = YES;
        //能够显示气泡，包括标题。。
        annoView.canShowCallout = YES;
        //只能用在MKAnnotationView类 pin类已经给了默认image
        NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"nearby-stadium.png"]);
        UIImage *image = [UIImage imageWithData:data scale:8];
        annoView.image = image;
        //配饰  UIView
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //[button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 40, 40);
        annoView.rightCalloutAccessoryView = button;
    }
    return annoView;
}
@end
