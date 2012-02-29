//
//  CustomNavigationController.h
//  SwingLife
//
//  Created by kong yang on 11-10-12.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@interface CustomNavigationController : UINavigationController<UserProfileErrorDelegate>
{
    UserProfile *userProfile;
}
@property (retain,nonatomic) UserProfile *userProfile;

-(void) showMessage: (NSString*) msg;

@end
