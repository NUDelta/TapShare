//
//  MyLocationTableViewController.h
//  MyLocationDemo
//
//  Created by Stephen Chan on 5/16/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBKeyboardHandler.h"
#import "KBKeyboardHandlerDelegate.h"
#import "MyLocationAppDelegate.h"

@interface MyLocationTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, KBKeyboardHandlerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *reportTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *reportMapSegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *titleText;

@end
