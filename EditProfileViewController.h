//
//  EditProfileViewController.h
//  ShowLuandan
//
//  Created by kong yang on 11-9-24.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeSomethingViewController.h"
#import "EditProfileHeadImageAndNameCellView.h"
#import "UserProfile.h"
#import "CustomTableViewCell.h"
#import "CustomNavigationController.h"
#import "UISinglePickerController.h"

@interface EditProfileViewController : UITableViewController<TypeSomethingViewControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UserProfileErrorDelegate, UISinglePickerControllerDelegate> {
    NSMutableDictionary *data;
    NSString *dataPath;
    UINib *headAndNameCellNib;
    EditProfileHeadImageAndNameCellView *headImgAndNameCellView;
    UserProfile *userProfile;
    BOOL inited;
}

- (IBAction)inputName:(id)sender;
- (IBAction)modifyHeadImage:(id)sender;
- (IBAction)editAge:(id)sender;
@property (nonatomic, retain) IBOutlet EditProfileHeadImageAndNameCellView *headImgAndNameCellView;
@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, copy) NSString *dataPath;
@property (nonatomic,retain) UINib *headAndNameCellNib;
@property (nonatomic, retain) UserProfile *userProfile;

-(void) showErrorMessage: (NSString*) errmsg;
-(void)pickImageFromPhotoLibrary;
-(void)pickImageByTakingPhoto;
-(void)deleteMyProfile;
@end
