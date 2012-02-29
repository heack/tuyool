//
//  TypeSomethingViewController.m
//  ShowLuandan
//
//  Created by kong yang on 11-9-25.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "TypeSomethingViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation TypeSomethingViewController
@synthesize textinput;
@synthesize delegate;
@synthesize profileflag;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    textinput.layer.cornerRadius = 6;
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textinput becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setTextinput:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [textinput release];
    [super dealloc];
}
- (IBAction)cancel:(id)sender {
    [delegate cancel];
}

- (IBAction)saveText:(id)sender {
    [delegate saveText:textinput.text profile:self.profileflag];
}

@end
