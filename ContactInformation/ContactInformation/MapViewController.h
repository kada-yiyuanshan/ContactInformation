//
//  MapViewController.h
//  ContactInformation
//
//  Created by perry on 12-11-8.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>
{
    MKMapView *mapview;
    NSString  *address;
    
}

@property(retain,nonatomic) NSString  *address;
@property (retain,nonatomic) IBOutlet MKMapView *mapview;
-(CLLocationCoordinate2D)getPostion:(NSString *)address;
-(void)message;
@end
