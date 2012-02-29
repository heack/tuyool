//
//  ViewOtherUserProfile.m
//  SwingLife
//
//  Created by kong yang on 11-10-6.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "ViewOtherUserProfile.h"
#import "ChatViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UserProfile.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import <CoreLocation/CoreLocation.h>
#import "CustomNavigationController.h"

@implementation ViewOtherUserProfile
@synthesize profilesTextView;
@synthesize introductionTextView;
@synthesize add_remove_favorite_button;
@synthesize headImage;
@synthesize selfId;
@synthesize targetId;

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
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    NSString *img_url_string = [[NSString alloc] initWithFormat:@"http://swinglife.crosslife.com/image.php?id=%@",self.targetId];
    NSURL *imgUrl = [[NSURL alloc] initWithString:img_url_string];
    [self.headImage setImageUrl:imgUrl];
    [img_url_string release];
    [imgUrl release];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    
    UIBarButtonItem *chatButton = [[UIBarButtonItem alloc] initWithTitle:@"Chat" style:UIBarButtonItemStyleBordered target:self action:@selector(enterChatController)];
    self.navigationItem.rightBarButtonItem = chatButton;
    [chatButton release];
    
    self.profilesTextView.layer.cornerRadius = 5.0f;
    self.introductionTextView.layer.cornerRadius = 5.0f;
    
    NSString *url_string = [[NSString alloc] initWithFormat:@"http://swinglife.crosslife.com/viewuserprofile.php?id=%@&ownid=%@",self.targetId, self.selfId];
    NSURL *url = [NSURL URLWithString:url_string];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [url_string release];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(@"get userprofile with response:%@", response);
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSDictionary *userData = [jsonParser objectWithString:response];
        NSLog(@"profiles:%@",[userData objectForKey:@"profiles"]);
        NSMutableString *profileString = [[NSMutableString alloc] init];
        NSString *isfriend = [userData objectForKey:@"isfriend"];
        NSLog(@"isfriend: %@", isfriend);
        if ([NSNull null] != isfriend && [isfriend isEqualToString:@"1"]) {
            isFavorite = YES;
            
            [add_remove_favorite_button setImage:[UIImage imageNamed:@"favorite_remove.png"] forState:UIControlStateNormal];
        } else {
            isFavorite = NO;
        }
        
        CustomNavigationController *nagController = (CustomNavigationController*)self.navigationController;
        UserProfile *up = nagController.userProfile;
        CLLocation *selfLocation = nil;
        CLLocation *targetLocation = nil;
        if (up.latitude!=nil && up.longitude!=nil) {
            selfLocation = [[CLLocation alloc] initWithLatitude:[up.latitude doubleValue] longitude:[up.longitude doubleValue]];
        }
        if (selfLocation != nil) {

            NSString *targetLatitude = [userData objectForKey:@"latitude"];
            NSString *targetLogtitude = [userData objectForKey:@"logtitude"];
            if(targetLatitude!=nil && targetLogtitude!=nil){
                targetLocation = [[CLLocation alloc] initWithLatitude:[targetLatitude doubleValue] longitude:[targetLogtitude doubleValue]];
            }
        }
        if(selfLocation!=nil && targetLocation!=nil)
        {
            NSString *distance = [[NSString alloc] initWithFormat:@"%.2f",[selfLocation distanceFromLocation:targetLocation]/1000];
            [profileString appendFormat:@"Distance:%@km\r\n",distance];
            [distance release];
        }
        
        if (targetLocation != nil) {
            [targetLocation release];
        }
        if (selfLocation != nil) {
            [selfLocation release];
        }
        
        
        
        if ([userData objectForKey:@"profiles"]!=nil) {
            
        
            NSDictionary *profiles = [jsonParser objectWithString:[userData objectForKey:@"profiles"]];
            NSString *age = [profiles objectForKey:@"age"];
            NSString *height = [profiles objectForKey:@"height"];
            NSString *weight = [profiles objectForKey:@"weight"];
            NSString *spouseage = [profiles objectForKey:@"spouseage"];
            NSString *spouseheight = [profiles objectForKey:@"spouseheight"];
            NSString *spouseweight = [profiles objectForKey:@"spouseweight"];
            NSString *lookingfor = [profiles objectForKey:@"lookingfor"];
            NSString *location = [profiles objectForKey:@"location"];
            
            if (location!=nil) {
                [profileString appendFormat:@"location:%@\r\n",location];
            }
            if (age!=nil) {
                [profileString appendFormat:@"age:%@\r\n",age];
            }
            if (height!=nil) {
                [profileString appendFormat:@"height:%@\r\n",height];
            }
            if (weight!=nil) {
                [profileString appendFormat:@"weight:%@\r\n",weight];
            }
            if (spouseage!=nil) {
                [profileString appendFormat:@"spouseage:%@\r\n",spouseage];
            }
            if (spouseheight!=nil) {
                [profileString appendFormat:@"spouseheight:%@\r\n",spouseheight];
            }
            if (spouseweight!=nil) {
                [profileString appendFormat:@"spouseweight:%@\r\n",spouseweight];
            }
            if (lookingfor!=nil) {
                [profileString appendFormat:@"looking for:\r\n%@\r\n",lookingfor];
            }
            
            
            NSString *introduction = [profiles objectForKey:@"introduction"];
            self.introductionTextView.text = introduction;
        }
        self.profilesTextView.text = profileString;
        [profileString release];

        
        [jsonParser release];
    } else {
        [self showErrorMessage:@"Please Check Your Network Connectoin."];
        
    }
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setHeadImage:nil];
    [self setProfilesTextView:nil];
    [self setIntroductionTextView:nil];
    [self setAdd_remove_favorite_button:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) enterChatController
{
    //NSLog(@"in enterChatController selfId:%@, targetId:%@", selfId,targetId);
    ChatViewController *chatViewController = [[ChatViewController alloc] init];
    [chatViewController setSelfId:selfId];
    [chatViewController setTargetId:targetId];
    [chatViewController setTitle:self.title];
    [self.navigationController pushViewController:chatViewController animated:YES];
    [chatViewController release];
    
}

- (IBAction)showHideButtonClick:(id)sender {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
    NSArray *views = self.view.subviews;
    for (UIView *view in views) {
        if ([view isKindOfClass:[UITextView class]] || ([view isKindOfClass:[UIButton class]] && view!=sender)) {
            if (showhideTextView==0) {
                [view setAlpha:0.0f];
            } else {
                [view setAlpha:1.0f];
            }

        }
    }
    [UIView commitAnimations];
    showhideTextView = 1-showhideTextView;
}

- (IBAction)addRemoveFavoriteButtonClick:(id)sender {
    if (!isFavorite) {
        CustomNavigationController *nagController = (CustomNavigationController*)self.navigationController;
        UserProfile *userProfile = nagController.userProfile;
        [userProfile addUserToFavorite:self.targetId];
    } else {
        CustomNavigationController *nagController = (CustomNavigationController*)self.navigationController;
        UserProfile *userProfile = nagController.userProfile;
        [userProfile removeUserFromFavorite:self.targetId];
    }
}

- (IBAction)chatButtonClick:(id)sender {
    [self enterChatController];
}

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

- (void)dealloc {
    [headImage release];
    [selfId release];
    [targetId release];
    [profilesTextView release];
    [introductionTextView release];
    [add_remove_favorite_button release];
    [super dealloc];
}
@end
