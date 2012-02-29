//
//  UIPhotoTableViewCell.m
//  ShowLuandan
//
//  Created by kong yang on 11-9-17.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "UIPhotoTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIPhotoTableViewCell

@synthesize name1;
@synthesize name2;
@synthesize name3;
@synthesize name4;
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize image1;
@synthesize image2;
@synthesize image3;
@synthesize image4;
@synthesize onlineStatusImage1;
@synthesize onlineStatusImage2;
@synthesize onlineStatusImage3;
@synthesize onlineStatusImage4;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [image1 release];
    [image2 release];
    [image3 release];
    [image4 release];

    [button1 release];
    [name1 release];
    [name2 release];
    [name3 release];
    [name4 release];
    [button2 release];
    [button3 release];
    [button4 release];
    [onlineStatusImage1 release];
    [onlineStatusImage2 release];
    [onlineStatusImage3 release];
    [onlineStatusImage4 release];
    [super dealloc];
}
@end
