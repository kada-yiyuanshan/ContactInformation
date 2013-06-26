//
//  MapViewController.m
//  ContactInformation
//
//  Created by perry on 12-11-8.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "MapViewController.h"
#import "JSON.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"
@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapview;
@synthesize address;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.navigationController.title=@"Address";
    }  
    return self;
}

- (void)viewDidLoad
{
    mapview = [[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
	mapview.delegate = self;
    [self.view addSubview:mapview];
    
    CLLocationCoordinate2D position= [self getPostion:self.address];
    MKCoordinateRegion theRegion = { {0.0, 0.0 }, { 0.0, 0.0 } };
  
    theRegion.center = position;
    theRegion.span.longitudeDelta = 0.01f;
    theRegion.span.latitudeDelta = 0.01f;
        DDAnnotation *annotation = [[[DDAnnotation alloc] initWithCoordinate:position addressDictionary:nil] autorelease];
        annotation.title = self.address;
        annotation.subtitle = [NSString	stringWithFormat:@"%f %f", annotation.coordinate.latitude, annotation.coordinate.longitude];
        
        [self.mapview addAnnotation:annotation];
    [mapview setRegion:theRegion animated:YES];
    [mapview setCenterCoordinate:position animated:YES];
    
    [super viewDidLoad];
}

-(CLLocationCoordinate2D)getPostion:(NSString *)_address
{
    NSString *googleURL = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=%@&sensor=true",[_address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    CLLocationCoordinate2D position;
    position.latitude = 0.0;
    position.longitude = 0.0;
    
    NSError *error;
    NSString *retstr = [NSString stringWithContentsOfURL:[NSURL URLWithString:googleURL] encoding:NSUTF8StringEncoding error:&error];
    if (retstr)
    {
        NSDictionary *dict = [retstr JSONValue];
        if (dict)
        {
            NSArray *results = [dict objectForKey:@"results"];
            if (results && results.count > 0)
            {
                NSDictionary *geometry = [[results objectAtIndex:0] objectForKey:@"geometry"];
                NSDictionary *location = [geometry objectForKey:@"location"];
                position.latitude = [[location objectForKey:@"lat"] doubleValue];
                position.longitude = [[location objectForKey:@"lng"] doubleValue];
                NSLog(@"####loacation is   %f %f",position.latitude,position.longitude);
            }
        }
    }
    else
    {
        NSLog(@"error: %@", error);
    }
    
    return position;
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if ( [error code] == kCLErrorDenied )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务已经关闭"
                                                        message:@"请您在设置页面中打开本软件的定位服务"
                                                       delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [manager stopUpdatingHeading];
    }
    else if ([error code] == kCLErrorHeadingFailure)
    {
        
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
	}
	
	static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
	MKAnnotationView *draggablePinView = [self.mapview dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
	
	if (draggablePinView) {
		draggablePinView.annotation = annotation;
	} else {
		// Use class method to create DDAnnotationView (on iOS 3) or built-in draggble MKPinAnnotationView (on iOS 4).
		draggablePinView = [DDAnnotationView annotationViewWithAnnotation:annotation reuseIdentifier:kPinAnnotationIdentifier mapView:self.mapview];
        
		if ([draggablePinView isKindOfClass:[DDAnnotationView class]]) {
			// draggablePinView is DDAnnotationView on iOS 3.
		} else {
			// draggablePinView instance will be built-in draggable MKPinAnnotationView when running on iOS 4.
		}
	}
	
	return draggablePinView;}
-(void)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL
                                                    message:@"无法确定位置"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(void)dealloc
{
    [address release];
    [super dealloc];
}
@end
