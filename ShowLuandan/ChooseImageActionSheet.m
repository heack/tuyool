//
//  ChooseImageActionSheet.m
//  SwingLife
//
//  Created by kong yang on 11-9-28.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "ChooseImageActionSheet.h"

@implementation ChooseImageActionSheet
//@synthesize chooseExistImageButton;
//@synthesize takePhotoButton;
//@synthesize cancelButton;
@synthesize cusview;
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        self.cusview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
        UIButton *chooseExistImageButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 320, 44)];
        [chooseExistImageButton setTitle:@"Choose Existing Photo" forState:UIControlStateNormal];
        [chooseExistImageButton addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *takePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 69, 320, 44)];
        [takePhotoButton setTitle:@"Take Photo" forState:UIControlStateNormal];
        [takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 123, 320, 44)];
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        [self.cusview addSubview:chooseExistImageButton];
        [self.cusview addSubview:takePhotoButton];
        [self.cusview addSubview:cancelButton];
        [chooseExistImageButton release];
        [takePhotoButton release];
        [cancelButton release];
        [self addSubview:self.cusview];
        layoutDone = NO;
    }
    
    return self;
}
-(void) layoutSubviews
{
    [super layoutSubviews];
    if (!layoutDone) {
        CGRect frame = [self frame];
        frame.size.height = 240;
        [self setFrame:frame];
        layoutDone = YES;
    }
    
}

-(void) chooseImage
{
    [self dismissWithClickedButtonIndex:1 animated:YES];
}

-(void) takePhoto
{
    [self dismissWithClickedButtonIndex:2 animated:YES];
}

-(void) cancel
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}



-(void) dealloc
{
//    [chooseExistImageButton release];
//    [takePhotoButton release];
//    [cancelButton release];
    [self.cusview release];
    [super dealloc];
}

@end
