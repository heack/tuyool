//
//  TypeSomethingViewController.h
//  ShowLuandan
//
//  Created by kong yang on 11-9-25.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeSomethingViewControllerDelegate <NSObject> 

-(void) saveText: (NSString*) text profile:(int) flag;
-(void) cancel;

@end


@interface TypeSomethingViewController : UIViewController {
    UITextView *textinput;
    int profileflag;
    id<TypeSomethingViewControllerDelegate> delegate;
}

- (IBAction)saveText:(id)sender;
- (IBAction)cancel:(id)sender;

@property (nonatomic, retain) IBOutlet UITextView *textinput;
@property (nonatomic) int profileflag;

@property (assign) id<TypeSomethingViewControllerDelegate> delegate;
@end


