//
//  CustomNavigationController.m
//  SwingLife
//
//  Created by kong yang on 11-10-12.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "CustomNavigationController.h"
#import "ASIFormDataRequest.h"

@implementation CustomNavigationController
@synthesize userProfile;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

-(void) viewWillAppear:(BOOL)animated
{
    if (self.userProfile == nil) {
        UserProfile *_userProfile = [[UserProfile alloc] initWithDelegate:self];
        [self setUserProfile:_userProfile];
        [_userProfile release];
    }
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//USER PROFILE Error Delegate
-(void) showErrorMessage: (NSString*) errmsg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error" 
                          message:errmsg 
                          delegate:nil 
                          cancelButtonTitle: @"Done"
                          otherButtonTitles:nil];
    [alert show];    
    [alert release];
}
-(void) showMessage: (NSString*) msg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Message" 
                          message:msg 
                          delegate:nil 
                          cancelButtonTitle: @"Done"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}
//USER PROFILE Error Delegate End

-(void) dealloc
{
    [userProfile release];
    [super dealloc];
}

//ASIRequest delegate begin

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    //NSString *responseString = [request responseString];
    
    // Use when fetching binary data
    //NSData *responseData = [request responseData];
    //NSLog(@"finished with response:%@", responseString);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"failed");
    [self showErrorMessage:@"Please check your network connection!"];
    //NSError *error = [request error];
}
//ASIRequest delegate end
@end
