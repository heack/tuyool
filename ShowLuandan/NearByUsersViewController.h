//
//  ShowLuandanViewController.h
//  ShowLuandan
//
//  Created by kong yang on 11-9-16.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPhotoTableViewCell.h"
#import "ViewUserProfileViewController.h"
#import "UIControlToolBarView.h"
#import "SelectUsersListTypeView.h"
#import "UserProfile.h"
#import <CoreLocation/CoreLocation.h>
#import "CustomNavigationController.h"
#import "SoundEffect.h"

@interface NearByUsersViewController : UITableViewController<UserProfileErrorDelegate,CLLocationManagerDelegate> {
    UINib *cellNib;
    UINib *toolBarNib;
    UINib *selectViewBarNib;
    UINib *selectIOCell;
    UIPhotoTableViewCell *photoCell;
    UIView *selectIOCellView;
    UIControlToolBarView *toolBar;
    SelectUsersListTypeView *selectViewBar;
    CGRect toolbar_atBottom;
    CGRect toolbar_justinfo;
    CGRect toolbar_totalHidden;
    Boolean showToolBar;
    UILabel *userid;
    UserProfile *userProfile;
    CLLocationManager *location;
    int data_source;
    BOOL only_showOnline;
    BOOL inited;
    BOOL isLocationLoaded;
    NSTimer *timer;
    
    UIImage *onlineImage;
    UIImage *offlineImage;
    
    SoundEffect *newMessageSound;
    UIView *disableViewOverlay;
}
- (IBAction)imageButtonClick:(id)sender;
- (IBAction)enterEditProfile:(id)sender;
- (IBAction)refreshUsers:(id)sender;
- (IBAction)loadRecentContact:(id)sender;
- (IBAction)loadFavoriteContact:(id)sender;
- (IBAction)loadNearByUsers:(id)sender;
- (IBAction)setOnlineOffline:(id)sender;
- (IBAction)loadSelectViews:(id)sender;
- (IBAction)loadRateUs:(id)sender;
- (IBAction)hideSelectViews:(id)sender;

-(UIImageView*) badgeImageView:(NSString *)text;

- (IBAction)toggleIOSwitch:(id)sender;

@property (nonatomic, retain) UIView *disableViewOverlay;
@property (nonatomic, retain) IBOutlet UILabel *userid;
@property (nonatomic,retain) IBOutlet UIPhotoTableViewCell *photoCell;
@property (nonatomic, retain) IBOutlet UIView *selectIOCellView;
@property (nonatomic,retain) UINib *cellNib;
@property (nonatomic,retain) UINib *toolBarNib;
@property (nonatomic,retain) UINib *selectViewBarNib;
@property (nonatomic,retain) UINib *selectIOCell;
@property (nonatomic, retain) IBOutlet UIControlToolBarView *toolBar;
@property (nonatomic, retain) IBOutlet SelectUsersListTypeView *selectViewBar;
@property (nonatomic, retain) UserProfile *userProfile;
@property (nonatomic, retain) CLLocationManager *location;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic,retain) UIImage *onlineImage;
@property (nonatomic, retain) UIImage *offlineImage;
@property (nonatomic, retain) SoundEffect *newMessageSound;

- (UIImage*) onlineImage;
- (UIImage*) offlineImage;
- (void) addDisableViewOverlay;
- (void) removeDisableViewOverlay;
- (void) hideSelectView;;

-(void) onTimer;
@end
