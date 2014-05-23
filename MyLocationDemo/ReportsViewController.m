//
//  ReportsViewController.m
//  MyLocationDemo
//
//  Created by Nicole Zhu on 4/17/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "ReportsViewController.h"

@interface ReportsViewController ()

@end

@implementation ReportsViewController
@synthesize mapView;
@synthesize numPothole;
@synthesize numCurb;
@synthesize numTrash;
@synthesize numLight;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    // Do any additional setup after loading the view.
    PFQuery *latest = [PFQuery queryWithClassName:@"Report"];
    [latest whereKey:@"event" equalTo:@"Pothole"];
    [latest getFirstObjectInBackgroundWithBlock:^(PFObject *recentPothole, NSError *error) {
        if (!recentPothole) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            NSLog(@"%@", recentPothole.objectId);
            NSString *event = recentPothole[@"event"];
            PFGeoPoint *geoPoint = [recentPothole objectForKey:@"location"];
            double lat = geoPoint.latitude;
            double lon = geoPoint.longitude;
            
            NSLog(@"%@", geoPoint);
            NSLog(@"%f", lat);
            NSLog(@"%f", lon);
            
            [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01, 0.01))];
            
            MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
            CLLocationCoordinate2D myCoordinate;
            myCoordinate.latitude=lat;
            myCoordinate.longitude=lon;
            annotation.coordinate = myCoordinate;
            [self.mapView addAnnotation:annotation];
            
        }
    }];
    
    
    
    PFQuery *pothole = [PFQuery queryWithClassName:@"Report"];
    [pothole whereKey:@"event" equalTo:@"Pothole"];
    [pothole findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d potholes.", objects.count);
            numPothole.text = [NSString stringWithFormat:@"%d", objects.count];
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                //NSString *event = objects[@"event"];
                //NSLog(@"%@", event);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *curbs = [PFQuery queryWithClassName:@"Report"];
    [curbs whereKey:@"event" equalTo:@"No Curb Ramp"];
    [curbs findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d curb ramps.", objects.count);
            numCurb.text = [NSString stringWithFormat:@"%d", objects.count];
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *trash = [PFQuery queryWithClassName:@"Report"];
    [trash whereKey:@"event" equalTo:@"Full Trash Can"];
    [trash findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d trash cans.", objects.count);
            numTrash.text = [NSString stringWithFormat:@"%d", objects.count];
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFQuery *lights = [PFQuery queryWithClassName:@"Report"];
    [lights whereKey:@"event" equalTo:@"Broken Street Light"];
    [lights findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d broken street lights.", objects.count);
            numLight.text = [NSString stringWithFormat:@"%d", objects.count];
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"returnHome"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
