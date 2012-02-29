//
//  CustomTableViewCell.h
//  SwingLife
//
//  Created by mac on 11-10-11.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@interface CustomTableViewCell : UITableViewCell<UserProfileErrorDelegate>
{
    UILabel *nameLabel;
    UILabel *detailLabel;
    UserProfile *userProfile;
    //int profileFlag;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *detailLabel;
@property (nonatomic, retain) UserProfile *userProfile;
//@property (nonatomic) int profileFlag;

-(void) saveName:(int) profileFlag;
//-(void) saveDetailLabel:(int) profileFlag;

@end

