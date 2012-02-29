//
//  EditProfileHeadImageAndNameCellView.h
//  SwingLife
//
//  Created by kong yang on 11-9-27.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileHeadImageAndNameCellView : UITableViewCell {
    UILabel *nameLabel;
    UIImageView *headImageView;
    UIView *rightView;
}


@property (nonatomic, retain) IBOutlet UIView *rightView;
@property (nonatomic, retain) IBOutlet UIImageView *headImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@end
