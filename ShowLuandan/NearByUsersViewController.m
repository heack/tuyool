//
//  ShowLuandanViewController.m
//  ShowLuandan
//
//  Created by kong yang on 11-9-16.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "NearByUsersViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#import "ASIFormDataRequest.h"
#import "ViewOtherUserProfile.h"
#import "Math.h"
#import "SoundEffect.h"


@implementation NearByUsersViewController

#define FROM_NEARBY_USERS 1
#define FROM_RECENT_CONTACTS 2
#define FROM_FAVORITE_CONTACTS 3

#define BADGEVIEW_TAG 10

@synthesize userid;
@synthesize photoCell;
@synthesize selectIOCellView;
@synthesize cellNib;
@synthesize toolBarNib;
@synthesize selectViewBarNib;
@synthesize selectIOCell;
@synthesize toolBar;
@synthesize selectViewBar;
@synthesize userProfile;
@synthesize location;
@synthesize timer;
@synthesize onlineImage;
@synthesize offlineImage;
@synthesize disableViewOverlay;
@synthesize newMessageSound;


-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSBundle *mainBundle = [NSBundle mainBundle];
        newMessageSound = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"NewMsg" ofType:@"caf"]];
    }
    return self;
}

//protocal

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *cellPhotoIdentifier = @"UIPhotoTableViewCell";
    UIPhotoTableViewCell *cell = (UIPhotoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellPhotoIdentifier];
    if(cell == nil){
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellPhotoIdentifier] autorelease];
//        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"UIPhotoTableViewCell"  owner:nil options:nil];
//        for (id curObject in array)
//        {
//            if ([curObject isKindOfClass:[UIPhotoTableViewCell class]]) 
//            {
//                cell = (UIPhotoTableViewCell*) curObject;
//                break;
//            }
//        }
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = photoCell;
        self.photoCell = nil;
        
    } else {
        //NSLog(@"reuse cell");
    }
    
//    NSURL *url = [[NSURL alloc] initWithString:@"http://d.crosslife.com/broadcast/info_files/4e72c0f57f8b9a215c000001"];
    NSArray *showUsers = nil;
    NSLog(@"here asdf");
    if (data_source == FROM_NEARBY_USERS) {
        showUsers = [self.userProfile getNearByUsers];
    } else if (data_source == FROM_RECENT_CONTACTS) {
        showUsers = [self.userProfile getRecentContacts];
    } else if (data_source == FROM_FAVORITE_CONTACTS) {
        NSLog(@"here 3");
        showUsers = [self.userProfile getFavoriteUsers];
    }
    
    NSDictionary *cell_one_data = [showUsers objectAtIndex:4*indexPath.row];
    NSDictionary *cell_two_data = nil;
    NSDictionary *cell_three_data = nil;
    NSDictionary *cell_four_data = nil;
    
    NSString *url1_string = [[NSString alloc] initWithFormat:@"http://swinglife.crosslife.com/image.php?id=%@&size=small",[cell_one_data objectForKey:@"id"]];
    NSURL *url1 = [[NSURL alloc] initWithString:url1_string];
    [cell.image1 setImageUrl:url1];
    cell.image1.layer.masksToBounds = YES;
    cell.image1.layer.cornerRadius = 4.0;
    [cell.button1 setUserProfileId:[cell_one_data objectForKey:@"id"]];
    [cell.button1 setUserName:[cell_one_data objectForKey:@"name"]];
    [cell.button1 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //[cell.button1 setUserProfileId:@"test1"];
    [cell.name1 setText:[cell_one_data objectForKey:@"name"]];
    [url1_string release];
    [url1 release];
    UIImageView *existedBadgeView = (UIImageView*) [cell.button1 viewWithTag:BADGEVIEW_TAG];
    if (existedBadgeView != nil) {
        [existedBadgeView removeFromSuperview];
    }
    if (data_source == FROM_RECENT_CONTACTS) {
        NSString *num = [cell_one_data objectForKey:@"num"];
        UIImageView *badgeView = [self badgeImageView:num];
        [badgeView setTag:BADGEVIEW_TAG];
        [cell.button1 addSubview:badgeView];
    } 
    //online status image
    NSString *onlineStatus = [cell_one_data objectForKey:@"isonline"];
    if ([onlineStatus isEqualToString:@"1"]) {
        [cell.onlineStatusImage1 setHidden:NO];
    } else {
        [cell.onlineStatusImage1 setHidden:YES];
    }
    
    if (4*indexPath.row+1 < [showUsers count]) {
        [cell.image2 setHidden:NO];
        [cell.button2 setHidden:NO];
        [cell.name2 setHidden:NO];
        
        cell_two_data = [showUsers objectAtIndex:4*indexPath.row+1];
        NSString *url2_string = [[NSString alloc] initWithFormat:@"http://swinglife.crosslife.com/image.php?id=%@&size=small",[cell_two_data objectForKey:@"id"]];
        NSURL *url2 = [[NSURL alloc] initWithString:url2_string];
        [cell.image2 setImageUrl:url2];
        cell.image2.layer.masksToBounds = YES;
        cell.image2.layer.cornerRadius = 4.0;
        [url2_string release];
        [url2 release];
        [cell.button2 setUserProfileId:[cell_two_data objectForKey:@"id"]];
        [cell.button2 setUserName:[cell_two_data objectForKey:@"name"]];
        [cell.button2 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.name2 setText:[cell_two_data objectForKey:@"name"]];
        UIImageView *existedBadgeView = (UIImageView*) [cell.button2 viewWithTag:BADGEVIEW_TAG];
        if (existedBadgeView != nil) {
            [existedBadgeView removeFromSuperview];
        }
        if (data_source == FROM_RECENT_CONTACTS) {
            NSString *num = [cell_two_data objectForKey:@"num"];
            UIImageView *badgeView = [self badgeImageView:num];
            [badgeView setTag:BADGEVIEW_TAG];
            [cell.button2 addSubview:badgeView];
        }
        //online status image
        NSString *onlineStatus = [cell_two_data objectForKey:@"isonline"];
        if ([onlineStatus isEqualToString:@"1"]) {
            [cell.onlineStatusImage2 setHidden:NO];
        } else {
            [cell.onlineStatusImage2 setHidden:YES];
        }
        
    } else {
        [cell.image2 setHidden:YES];
        [cell.button2 setHidden:YES];
        [cell.name2 setHidden:YES];
        [cell.onlineStatusImage2 setHidden:YES];
    }
    if (4*indexPath.row+2 < [showUsers count]) {
        [cell.image3 setHidden:NO];
        [cell.button3 setHidden:NO];
        [cell.name3 setHidden:NO];
        
        cell_three_data = [showUsers objectAtIndex:4*indexPath.row+2];
        NSString *url3_string = [[NSString alloc] initWithFormat:@"http://swinglife.crosslife.com/image.php?id=%@&size=small",[cell_three_data objectForKey:@"id"]];
        NSURL *url3 = [[NSURL alloc] initWithString:url3_string];
        [cell.image3 setImageUrl:url3];
        cell.image3.layer.masksToBounds = YES;
        cell.image3.layer.cornerRadius = 4.0;
        [url3_string release];
        [url3 release];
        [cell.button3 setUserProfileId:[cell_three_data objectForKey:@"id"]];
        [cell.button3 setUserName:[cell_three_data objectForKey:@"name"]];
        [cell.button3 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.name3 setText:[cell_three_data objectForKey:@"name"]];
        UIImageView *existedBadgeView = (UIImageView*) [cell.button3 viewWithTag:BADGEVIEW_TAG];
        if (existedBadgeView != nil) {
            [existedBadgeView removeFromSuperview];
        }
        if (data_source == FROM_RECENT_CONTACTS) {
            NSString *num = [cell_three_data objectForKey:@"num"];
            UIImageView *badgeView = [self badgeImageView:num];
            [badgeView setTag:BADGEVIEW_TAG];
            [cell.button3 addSubview:badgeView];
        }
        //online status image
        NSString *onlineStatus = [cell_three_data objectForKey:@"isonline"];
        if ([onlineStatus isEqualToString:@"1"]) {
            [cell.onlineStatusImage3 setHidden:NO];
        } else {
            [cell.onlineStatusImage3 setHidden:YES];
        }
    } else {
        [cell.image3 setHidden:YES];
        [cell.button3 setHidden:YES];
        [cell.name3 setHidden:YES];
        [cell.onlineStatusImage3 setHidden:YES];
    }
    
    if (4*indexPath.row+3 < [showUsers count]) {
        [cell.image4 setHidden:NO];
        [cell.button4 setHidden:NO];
        [cell.name4 setHidden:NO];
        
        cell_four_data = [showUsers objectAtIndex:4*indexPath.row+3];
        NSString *url4_string = [[NSString alloc] initWithFormat:@"http://swinglife.crosslife.com/image.php?id=%@&size=small",[cell_four_data objectForKey:@"id"]];
        NSURL *url4 = [[NSURL alloc] initWithString:url4_string];
        [cell.image4 setImageUrl:url4];
        cell.image4.layer.masksToBounds = YES;
        cell.image4.layer.cornerRadius = 4.0;
        [url4_string release];
        [url4 release];
        [cell.button4 setUserProfileId:[cell_four_data objectForKey:@"id"]];
        [cell.button4 setUserName:[cell_four_data objectForKey:@"name"]];
        [cell.button4 addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.name4 setText:[cell_four_data objectForKey:@"name"]];
        UIImageView *existedBadgeView = (UIImageView*) [cell.button4 viewWithTag:BADGEVIEW_TAG];
        if (existedBadgeView != nil) {
            [existedBadgeView removeFromSuperview];
        }
        if (data_source == FROM_RECENT_CONTACTS) {
            NSString *num = [cell_four_data objectForKey:@"num"];
            UIImageView *badgeView = [self badgeImageView:num];
            [badgeView setTag:BADGEVIEW_TAG];
            [cell.button4 addSubview:badgeView];
        }
        //online status image
        NSString *onlineStatus = [cell_four_data objectForKey:@"isonline"];
        if ([onlineStatus isEqualToString:@"1"]) {
            [cell.onlineStatusImage4 setHidden:NO];
        } else {
            [cell.onlineStatusImage4 setHidden:YES];
        }
        
    } else {
        [cell.image4 setHidden:YES];
        [cell.button4 setHidden:YES];
        [cell.name4 setHidden:YES];
        [cell.onlineStatusImage4 setHidden:YES];
    }
    
    
    return cell;
}

-(UIImageView*) badgeImageView:(NSString *)text
{
    if ([text isEqualToString:@"0"]) {
        return nil;
    }
    UIImage *badge = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"badge" ofType:@"png"]];
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(25.0f, 25.0f) lineBreakMode:  UILineBreakModeWordWrap];
    
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 2.0f, size.width, size.height)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = UILineBreakModeWordWrap;
    bubbleText.text = text;
    bubbleText.textAlignment = UITextAlignmentCenter;
    bubbleText.textColor = [UIColor whiteColor];
    
    UIImageView *badgeImageView = [[UIImageView alloc] initWithImage:[badge stretchableImageWithLeftCapWidth:10 topCapHeight:0]];
    badgeImageView.frame = CGRectMake(50.0f, 0.0f, 25.0f, 25.0f);
    [badgeImageView addSubview:bubbleText];
    [bubbleText release];
    return [badgeImageView autorelease];

}

- (IBAction)toggleIOSwitch:(id)sender {
    
    [self.userProfile setIsOnlyShowOnlineUsers:[(UISwitch *)sender isOn]];
    [self refreshUsers:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    if (!isLocationLoaded) {
        return 0;
    }
    NSArray *showUsers = nil;
    if (data_source == FROM_NEARBY_USERS) {
        showUsers = [self.userProfile getNearByUsers];
    } else if (data_source == FROM_RECENT_CONTACTS) {
        showUsers = [self.userProfile getRecentContacts];
    } else if (data_source == FROM_FAVORITE_CONTACTS) {
        showUsers = [self.userProfile getFavoriteUsers];
    }
    return ceil((float)[showUsers count]/4);
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 130.0;
//}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.navigationItem.title = @"SwingLife";
    self.tableView.rowHeight = 79.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self.tableView setBackgroundColor:[UIColor colorWithRed:40/256 green:40/256 blue:40/256 alpha:1.0]];
    
    self.cellNib = [UINib nibWithNibName:@"UIPhotoTableViewCell" bundle:nil];
    self.selectIOCell = [UINib nibWithNibName:@"selectOnlineOfflineCell" bundle:nil];
    self.tableView.allowsSelection = NO;

    //get location information
    CLLocationManager *_location = [[CLLocationManager alloc] init];
    [self setLocation:_location];
    [_location release];
    self.location.delegate = self;
    self.location.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.location startMonitoringSignificantLocationChanges];
    NSLog(@"userid: %@", self.userProfile.userId);
    
    UIImage *backgroundImage = [UIImage imageNamed:@"table_background@2.png"];
    UIImageView *tableabckgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    [self.tableView setBackgroundView:tableabckgroundView];
    CustomNavigationController *cusController = (CustomNavigationController*)self.navigationController;
    UserProfile *userProfile = cusController.userProfile;
    [userProfile checkNewVersion];
    [super viewDidLoad];
}
-(void) viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    self.timer = nil;
    toolBar.frame = toolbar_totalHidden;
}
-(void) viewWillAppear:(BOOL)animated
{
    
    
    if (self.userProfile == nil) {
        CustomNavigationController *nagController = (CustomNavigationController*)self.navigationController;
        [self setUserProfile:nagController.userProfile];
        if (!inited) {
            [self.userProfile setOnline];
        }
    }
    if (data_source == 0 ) {
        data_source = FROM_NEARBY_USERS;
    }
    
    if (data_source == FROM_NEARBY_USERS && !inited) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 66)];
        [self.selectIOCell instantiateWithOwner:self options:nil];
        UIView *ioView = self.selectIOCellView;
        self.selectIOCellView = nil;
        ioView.frame = CGRectMake(10, 0, 300.0f, 44);
        ioView.layer.cornerRadius = 5.0f;
        [footerView addSubview:ioView];
        [self.tableView setTableFooterView:footerView];
    }

    if (!self.toolBar) {
        self.toolBarNib = [UINib nibWithNibName:@"UIControlToolBarView" bundle:nil];
        [self.toolBarNib instantiateWithOwner:self options:nil];
        //self.toolBar.barStyle = UIBarStyleDefault;
        [self.toolBar sizeToFit];
        //Caclulate the height of the toolbar 
        CGFloat toolbarHeight = [toolBar frame].size.height;
        
        //Get the bounds of the parent view 
        CGRect rootViewBounds = self.parentViewController.view.bounds;
        
        //Get the height of the parent view. 
        CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
        
        //Get the width of the parent view, 
        CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
        
        //Create a rectangle for the toolbar 
        toolbar_atBottom = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
        toolbar_justinfo = CGRectMake(0, rootViewHeight -20.0, rootViewWidth, toolbarHeight);
        toolbar_totalHidden = CGRectMake(0, rootViewHeight, rootViewWidth, toolbarHeight);
        //Reposition and resize the receiver 
        [toolBar setFrame:toolbar_justinfo];
        [self.navigationController.view addSubview:toolBar];
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showHideTabbar)];
        self.navigationItem.rightBarButtonItem = menuButton;
        [menuButton release];
    }
    NSString *userName = [[NSString alloc] initWithFormat:@"Name:%@",self.userProfile.userName];
    [self.toolBar.userName setText:userName];
    [userName release];
    [UIView animateWithDuration:0.2 animations:^{toolBar.frame = toolbar_justinfo;} completion:^(BOOL finished){  }];
    showToolBar = false;
    [self setTimer:[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES]];
    
    
    
    inited = YES;
    [super viewWillAppear:animated];
        
}

-(void) viewDidAppear:(BOOL)animated
{
    [self onTimer];
    [super viewDidAppear:animated];
}

-(void) onTimer
{
    NSString *oldnum = self.toolBar.totalUnreadNumLabel.text;
    NSString *num = [self.userProfile getTotalUnreadNum];
    [self.toolBar.totalUnreadNumLabel setText:num];
    if (![num isEqualToString:@"0"] && ![num isEqualToString:oldnum]) {
        [newMessageSound play];
    }
}
-(void)showHideTabbar
{
    if (showToolBar) {
        showToolBar = false;
        [UIView animateWithDuration:0.2 animations:^{toolBar.frame = toolbar_justinfo;} completion:^(BOOL finished){  }];
    } else {
        showToolBar = true;
        [UIView animateWithDuration:0.2 animations:^{toolBar.frame = toolbar_atBottom;} completion:^(BOOL finished){  }];
    }
    
}
-(void) viewDidDisappear:(BOOL)animated
{
        NSLog(@"*********viewDidDisappear**********");
}

- (void)viewDidUnload
{
        NSLog(@"*********viewDidUnload**********");
    [self setToolBar:nil];
    [self setUserid:nil];
    [self setSelectIOCellView:nil];
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
    [newMessageSound release];
    [onlineImage release];
    [offlineImage release];
    [photoCell release];
    [cellNib release];
    [selectIOCell release];
    [toolBarNib release];
    [toolBar release];
    [selectViewBarNib release];
    [selectViewBar release];
    [userid release];
    [userProfile release];
    [location   release];
    [selectIOCellView release];
    [disableViewOverlay release];
    [super dealloc];
}

- (UIImage*) onlineImage
{
    if (onlineImage == nil) {
        onlineImage = [UIImage imageNamed:@"status_online.png"];
    }
    return onlineImage;
}
- (UIImage*) offlineImage
{
    if (offlineImage == nil) {
        offlineImage = [UIImage imageNamed:@"status_offline.png"];
    }
    return offlineImage;
}

- (IBAction)imageButtonClick:(id)sender {
    UIImageCusButton *button  = (UIImageCusButton*) sender;
    ViewOtherUserProfile *otherUserController = [[ViewOtherUserProfile alloc]initWithNibName:@"ViewOtherUserProfile" bundle:nil];
    [otherUserController setTargetId:button.userProfileId];
    [otherUserController setSelfId:userProfile.userId];
    otherUserController.title = button.userName;
    otherUserController.navigationItem.title = button.userName;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    
    [self.navigationController pushViewController:otherUserController animated:YES];
    [otherUserController release];
}

- (IBAction)enterEditProfile:(id)sender {
    UIImageCusButton *button  = (UIImageCusButton*) sender;
    ViewUserProfileViewController *userProfileController = [[ViewUserProfileViewController alloc] initWithStyle:UITableViewStyleGrouped];
    userProfileController.title = button.userProfileId;
    userProfileController.navigationItem.title = @"Settings";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    
    [self.navigationController pushViewController:userProfileController animated:YES];
    [userProfileController release];
}

- (IBAction)refreshUsers:(id)sender {
    [self.userProfile setNearbyUsers:nil];
    [self.userProfile setRecentContacts:nil];
    [self.userProfile setFavoriteUsers:nil];
    //UITableView *selfTableView = (UITableView*) self.view;
    [self.tableView reloadData];
}

- (IBAction)loadRecentContact:(id)sender {
    [self hideSelectView];
    data_source = FROM_RECENT_CONTACTS;
    [self.userProfile setRecentContacts:nil];
    [self.toolBar.showModLabel setText:@"Contact History"];
    [self.tableView.tableFooterView setHidden:YES];
    [self.tableView reloadData];
}

- (IBAction)loadNearByUsers:(id)sender {
    [self hideSelectView];
    data_source = FROM_NEARBY_USERS;
    [self.userProfile setNearbyUsers:nil];
    [self.toolBar.showModLabel setText:@"Nearby Users"];
    [self.tableView.tableFooterView setHidden:NO];
    [self.tableView reloadData];
}

- (IBAction)loadFavoriteContact:(id)sender {
    [self hideSelectView];
    data_source = FROM_FAVORITE_CONTACTS;
    [self.userProfile setFavoriteUsers:nil];
    [self.toolBar.showModLabel setText:@"Favorite Users"];
    [self.tableView.tableFooterView setHidden:NO];
    [self.tableView reloadData];
}

- (IBAction)setOnlineOffline:(id)sender {
    if (self.userProfile.isOnline == 1) {
        [self.toolBar.onlineOfflineLabel setText:@"Offline"];
        [self.toolBar.goOnlineOfflineLabel setText:@"Go Online"];
        [self.toolBar.onlineStatusImageView setImage:self.offlineImage];
        [self.userProfile setOffline];
    } else {
        [self.toolBar.onlineOfflineLabel setText:@"Online"];
        [self.toolBar.goOnlineOfflineLabel setText:@"Go Offline"];
        [self.toolBar.onlineStatusImageView setImage:self.onlineImage];
        [self.userProfile setOnline];
    }
}

- (IBAction)loadSelectViews:(id)sender {
    [self addDisableViewOverlay];
    [self showHideTabbar];
    if (!self.selectViewBar) {
        self.selectViewBarNib = [UINib nibWithNibName:@"SelectUsersListTypeView" bundle:nil];
        [self.selectViewBarNib instantiateWithOwner:self options:nil];
        self.selectViewBar.layer.masksToBounds = YES;
        self.selectViewBar.layer.cornerRadius = 4.0;
        self.selectViewBar.frame = CGRectMake(24, 380, 272, 44);
        
    }
    [self.navigationController.view addSubview:self.selectViewBar];
}

- (void) hideSelectView {
    [self removeDisableViewOverlay];
    [self.selectViewBar removeFromSuperview];
}

- (IBAction)loadRateUs:(id)sender {
    [[UIApplication sharedApplication] 
     openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/swinglife/id475584720?mt=8"]];
}

- (IBAction)hideSelectViews:(id)sender {
    [self hideSelectView];
}

- (void) addDisableViewOverlay {
    if (!self.disableViewOverlay) {
        self.disableViewOverlay = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,480.0f)];  
        self.disableViewOverlay.backgroundColor=[UIColor blackColor];  
        self.disableViewOverlay.alpha = 0.6; 
    }
    [self.navigationController.view addSubview:self.disableViewOverlay];  
}
- (void) removeDisableViewOverlay {
    //if (!self.disableViewOverlay) {
        [self.disableViewOverlay removeFromSuperview];
    //}
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
//USER PROFILE Error Delegate End
//Location Delegate
- (void) locationManager: (CLLocationManager *) manager
     didUpdateToLocation: (CLLocation *) newLocation
            fromLocation: (CLLocation *) oldLocation{
    NSString *lng = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.longitude];
    NSString *lat = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.latitude];
    [self.userProfile saveLongitude:lng withLatitude:lat];
    [lng release];
    [lat release];
    isLocationLoaded = YES;
    [self.tableView reloadData];
}
- (void) locationManager: (CLLocationManager *) manager didFailWithError: (NSError *) error {
    
    NSString *msg = [[NSString alloc] 
                     initWithString:@"Error obtaining location!"];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error" 
                          message:msg 
                          delegate:nil 
                          cancelButtonTitle: @"Done"
                          otherButtonTitles:nil];
    [alert show];    
    [msg release];
    [alert release];
    isLocationLoaded = YES;
    [self.tableView reloadData];
}

//Location Delegate End
@end
