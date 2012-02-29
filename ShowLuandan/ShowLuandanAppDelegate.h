//
//  ShowLuandanAppDelegate.h
//  ShowLuandan
//
//  Created by kong yang on 11-9-16.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import "CustomNavigationController.h"

@class NearByUsersViewController;

@interface ShowLuandanAppDelegate : NSObject <UIApplicationDelegate,UserProfileErrorDelegate> {
    CustomNavigationController *_navagationController;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain) IBOutlet CustomNavigationController *navagationController;


-(IBAction)imageOnClick:(id)sender;
@end
