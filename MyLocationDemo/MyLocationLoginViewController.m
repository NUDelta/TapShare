//
//  MyLocationLoginViewController.m
//  MyLocationDemo
//
//  Created by Stephen Chan on 5/21/14.
//  Copyright (c) 2014 Delta Hackers. All rights reserved.
//

#import "MyLocationLoginViewController.h"

@interface MyLocationLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;

@end

@implementation MyLocationLoginViewController {
    KBKeyboardHandler *keyboard;
}

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
    keyboard = [[KBKeyboardHandler alloc] init];
    keyboard.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([PFUser currentUser] && [[PFUser currentUser] isAuthenticated]) {
        NSLog(@"%@", [PFUser currentUser]);
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.loginTextField resignFirstResponder];
    if ([segue.identifier isEqualToString:@"login"]) {
        PFUser *user = [PFUser user];
        user.username = self.loginTextField.text;
        user.password = @"";
        [PFUser logInWithUsername:self.loginTextField.text password:@""];
        [user signUpInBackground];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardSizeChanged:(CGSize)delta {
    CGRect frame = [self.view frame];
    frame.origin.y -= delta.height;
    self.view.frame = frame;
}

@end
