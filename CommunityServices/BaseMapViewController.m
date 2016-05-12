//
//  BaseMapViewController.m
//  SearchV3Demo
//
//  Created by songjian on 13-8-14.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "BaseMapViewController.h"

@interface BaseMapViewController()

@property (nonatomic, assign) BOOL isFirstAppear;

@end

@implementation BaseMapViewController
@synthesize mapView = _mapView;

#pragma mark - Utility

- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
    [AMapLocationServices sharedServices].apiKey =@"7dd8fc4bbdd285cc112091f233516895";

}

#pragma mark - Handle Action

- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
}

#pragma mark - Initialization

- (void)initMapView
{   self.mapView = [[MAMapView alloc] init];
    self.mapView.frame = self.view.bounds;
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = YES;
    
    [self.view addSubview:self.mapView];
}

//- (void)initBaseNavigationBar
//{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
//                                                                             style:UIBarButtonItemStyleBordered
//                                                                            target:self
//                                                                            action:@selector(returnAction)];
//}

- (void)initTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.text             = title;
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - Life Cycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_isFirstAppear)
    {
        self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
        _isFirstAppear = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isFirstAppear = YES;
    
    [self initTitle:self.title];
    
//    [self initBaseNavigationBar];
    
    [self initMapView];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];

}

@end
