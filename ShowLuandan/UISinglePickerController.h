//
//  UISinglePickerController.h
//  SwingLife
//
//  Created by mac on 11-10-16.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@protocol UISinglePickerControllerDelegate <NSObject> 

-(void) saveText: (NSString*) text profile:(int) flag;
-(void) cancel;

@end

@interface UISinglePickerController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    IBOutlet UIPickerView *pickerview;
    IBOutlet UILabel *label;
    int profileflag;
    id<UISinglePickerControllerDelegate> delegate;
}

@property (nonatomic, retain) UIPickerView *pickerview;
@property (nonatomic, retain) UILabel *label;
@property (assign) id<UISinglePickerControllerDelegate> delegate;
@property (nonatomic) int profileflag;

-(IBAction)saveText:(id)sender;
-(IBAction)cancel:(id)sender;

@end
