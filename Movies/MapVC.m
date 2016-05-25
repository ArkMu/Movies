//
//  MapVC.m
//  Movies
//
//  Created by qingyun on 16/5/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MapVC.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <CoreLocation/CoreLocation.h>

#import "Masonry.h"

#import "UIView+Toast.h"

@interface MapVC () <BMKMapViewDelegate, BMKLocationServiceDelegate, UISearchBarDelegate, BMKPoiSearchDelegate>

@end

BMKMapView *_mapView;
BMKLocationService *_locService;
UISearchBar *_searBar;
BMKPoiSearch *_search;
int _curPage;
CLLocationCoordinate2D _coor;

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewControllerAnimated:completion:)];
    
    _mapView = [[BMKMapView alloc] init];
    [self.view addSubview:_mapView];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(self.view);
    }];
    
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    _locService.desiredAccuracy = kCLLocationAccuracyBest;
    _locService.distanceFilter = 100.f;
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = YES;

//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
//        [_locationManager requestWhenInUseAuthorization];
//    }
//    
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    self.locationManager.distanceFilter = 100.f;
    
    _searBar = [[UISearchBar alloc] init];
    _searBar.delegate = self;
    self.navigationItem.titleView = _searBar;
    
    _search = [[BMKPoiSearch alloc] init];
    _search.delegate = self;
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
    option.pageIndex = _curPage;
    option.pageCapacity = 10;
    option.location = _coor;
    option.keyword = searchBar.text;
    
    BOOL flag = [_search poiSearchNearBy:option];

    if (flag) {
        NSLog(@"ok");
    } else {
        NSLog(@"wrong");
    }

}

-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        
    } else {
        NSLog(@"%d", errorCode);
    }
}

-(void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        
    } else {
        [[UIView alloc] makeToast:@"未能找到结果"];
        
    }
}

-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor = userLocation.location.coordinate;
    _coor = coor;
    annotation.coordinate = coor;
    annotation.title = userLocation.title;
    [_mapView addAnnotation:annotation];
    
    BMKCoordinateRegion region;
    region.center = userLocation.location.coordinate;
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    region.span = span;
    [_mapView setRegion:region];
    
}



//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//    CLLocation *location = locations.lastObject;
//    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
//    CLLocationCoordinate2D coor = location.coordinate;
//    annotation.coordinate = coor;
//    annotation.title = @"我";
//    [_mapView addAnnotation:annotation];
//}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self.navigationController popViewControllerAnimated:flag];
}

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
