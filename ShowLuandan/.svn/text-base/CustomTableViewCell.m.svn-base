//
//  CustomTableViewCell.m
//  SwingLife
//
//  Created by mac on 11-10-11.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

#define INTRO 0
#define LOOKFOR 1
#define LOCATION 2
#define AGE 3
#define HEIGHT 4
#define WEIGHT 5
#define SPOUSEAGE 6
#define SPOUSEWEIGHT 8
#define SPOUSEHEIGHT 7
#define MAXMINAGE 9

@synthesize nameLabel;
@synthesize detailLabel;
@synthesize userProfile;

//@synthesize profileFlag;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, 150, 14)];
        [detailLabel setFont:[UIFont systemFontOfSize:12.0]];
        [detailLabel setTextColor:[UIColor blackColor]];
        [detailLabel setHighlightedTextColor:[UIColor whiteColor]];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        //[detailLabel setText:@"Detail Test"];
        [self.contentView addSubview:detailLabel];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 150, 20)];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        //[nameLabel setText:@"Test"];
        [self.contentView addSubview:nameLabel];
//        
//        UIButton *edit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        edit.frame = CGRectMake(245, 9, 45, 25);
//        [edit setTitle:@"Edit" forState:UIControlStateNormal];
//        edit.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
//        edit.backgroundColor = [UIColor clearColor];
//        [edit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        UIImage *buttonImage = [UIImage imageNamed:@"blueButton.png"];
//        UIImage *strechableButton = [buttonImage stretchableImageWithLeftCapWidth:15 topCapHeight:0];
//        
//        [edit setBackgroundImage:strechableButton forState:UIControlStateNormal];
//        
//        [self.contentView addSubview:edit];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) saveName:(int)profileFlag
{
    NSString *detaillabel = @"Do Not Show";
    
    switch (profileFlag)
    {
        case INTRO:
            [self.nameLabel setText:@"Introduction"];
            [self.detailLabel setText:self.userProfile.introduction];
            break;
        case LOOKFOR:
            [self.nameLabel setText:@"Looking For"];
            if (self.userProfile.location == nil)
            {
                [self.detailLabel setText:detaillabel];
            }else
            {
                [self.detailLabel setText:self.userProfile.lookingFor];
            }
            break;
        case LOCATION:
            [self.nameLabel setText:@"Location"];
            if (self.userProfile.location == nil)
            {
                [self.detailLabel setText:detaillabel];
            }else
            {
                [self.detailLabel setText:self.userProfile.location];
            }
            break;
        case AGE:
            [self.nameLabel setText:@"Age"];
            if (self.userProfile.age == nil)
            {
                [self.detailLabel setText:detaillabel];
            }else
            {
                [self.detailLabel setText:self.userProfile.age];
            }
            break;
        case HEIGHT:
            [self.nameLabel setText:@"Height"];
            if (self.userProfile.height == nil)
            {
                [self.detailLabel setText:detaillabel];
            }else
            {
                [self.detailLabel setText:self.userProfile.height];
            }
            break;
        case WEIGHT:
            [self.nameLabel setText:@"Weight"];
            if (self.userProfile.weight == nil)
            {
                [self.detailLabel setText:detaillabel];
            }else
            {
                [self.detailLabel setText:self.userProfile.weight];
            }
            break;
        case SPOUSEAGE:
            [self.nameLabel setText:@"Spouse Age"];
            if (self.userProfile.spouseage == nil)
            {
                [self.detailLabel setText:detaillabel];
            }else
            {
                [self.detailLabel setText:self.userProfile.spouseage];
            }
            break;
        case SPOUSEWEIGHT:
            [self.nameLabel setText:@"Spouse Weight"];
            if (self.userProfile.spouseweight == nil)
            {
                [self.detailLabel setText:detaillabel];
            }else
            {
                [self.detailLabel setText:self.userProfile.spouseweight];
            }
            break;
        case SPOUSEHEIGHT:
            [self.nameLabel setText:@"Spouse Height"];
            if (self.userProfile.spouseheight == nil)
            {
                [self.detailLabel setText:detaillabel];
            }else
            {
                [self.detailLabel setText:self.userProfile.spouseheight];
            }
            break;
        case MAXMINAGE:
            [self.nameLabel setText:@"Age Filter"];
            if (self.userProfile.maxage == nil && self.userProfile.minage == nil)
            {
                [self.detailLabel setText:@"All ages"];
            }
            if (self.userProfile.maxage != nil && self.userProfile.minage == nil)
            {
                [self.detailLabel setText:[NSString stringWithFormat:@"Below %@", self.userProfile.maxage]];
            }
            if (self.userProfile.minage != nil && self.userProfile.maxage == nil)
            {
                [self.detailLabel setText:[NSString stringWithFormat:@"Beyond %@", self.userProfile.minage]];
            }
            if (self.userProfile.maxage != nil && self.userProfile.minage != nil)
            {
                [self.detailLabel setText:[NSString stringWithFormat:@"Between %@ and %@", self.userProfile.minage, self.userProfile.maxage]];
            }
            break;
        default:
            [self.nameLabel setText:@"Test"];
            [self.detailLabel setText:@"Detail Text"];
            break;
    }
}

/*- (void)saveDetailLabel:(int)profileFlag
{
    [self.detailLabel setText:@"Detail Test"];
}*/

-(void) showErrorMessage: (NSString*) errmsg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error" 
                          message:errmsg 
                          delegate:nil 
                          cancelButtonTitle: @"Done"
                          otherButtonTitles:nil];
    [alert show];    
    [alert release];
}

- (void)dealloc {
    [nameLabel release];
    [detailLabel release];
    [userProfile release];
    [super dealloc];
}

@end
