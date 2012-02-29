//
//  CustomSettingsCell.m
//  SwingLife
//
//  Created by kong yang on 11-9-30.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "CustomSettingsCell.h"

@implementation CustomSettingsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.imageView.frame = CGRectMake(7,7,30,30);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
