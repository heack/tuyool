//
//  ViewOtherUserProfile.h
//  SwingLife
//
//  Created by kong yang on 11-10-6.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface ViewOtherUserProfile : UIViewController {
    NSString *targetId;
    NSString *selfId;
    BOOL isFavorite;
    AsyncImageView *headImage;
    
    UITextView *profilesTextView;
    UITextView *introductionTextView;
    int showhideTextView;
}

@property (nonatomic, retain) IBOutlet UITextView *profilesTextView;
@property (nonatomic, retain) IBOutlet UITextView *introductionTextView;
@property (retain, nonatomic) IBOutlet UIButton *add_remove_favorite_button;

@property (nonatomic, retain) IBOutlet AsyncImageView *headImage;
@property (nonatomic, copy) NSString *targetId;
@property (nonatomic, copy) NSString *selfId;
- (IBAction)showHideButtonClick:(id)sender;
- (IBAction)addRemoveFavoriteButtonClick:(id)sender;
- (IBAction)chatButtonClick:(id)sender;

-(void) showErrorMessage: (NSString*) errmsg;
@end
