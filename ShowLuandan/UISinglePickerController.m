//
//  UISinglePickerController.m
//  SwingLife
//
//  Created by mac on 11-10-16.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "UISinglePickerController.h"

@implementation UISinglePickerController

#define VIEW_TAG 41
#define SUB_LABEL_TAG 42
#define LABEL_TAG 43

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

@synthesize pickerview;
@synthesize delegate;
@synthesize profileflag;
@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    switch (self.profileflag)
    {
        case AGE:
            self.label.text = @"Age";
            break;
        case LOOKFOR:
            self.label.text = @"Looking For";
            break;
        case WEIGHT:
            self.label.text = @"Weight";
            break;
        case SPOUSEAGE:
            self.label.text = @"Spouse Age";
            break;
        case SPOUSEWEIGHT:
            self.label.text = @"Spouse Weight";
            break;
        case HEIGHT:
            self.label.text = @"Height";
            break;
        case SPOUSEHEIGHT:
            self.label.text = @"Spouse Height";
            break;
        default:
            self.label.text = @"test";
            break;
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	
    if (self.profileflag == HEIGHT || self.profileflag == SPOUSEHEIGHT)
    {
        return 2;
    }else
    {
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSInteger retValue;
    
    switch (self.profileflag) {
        case AGE:
        case SPOUSEAGE:
            retValue = 83;
            break;
        case LOOKFOR:
            retValue = 4;
            break;
        case WEIGHT:
        case SPOUSEWEIGHT:
            retValue = 340;
            break;
        case HEIGHT:
        case SPOUSEHEIGHT:
            if (component == 0)
                retValue = 4;
            else
                retValue = 12;
            break;
        default:
            break;
    }
    return retValue;
}

- (UIView *)labelCellWithWidth:(CGFloat)width rightOffset:(CGFloat)offset {
	
	// Create a new view that contains a label offset from the right.
	CGRect frame = CGRectMake(0.0, 0.0, width, 32.0);
	UIView *view = [[[UIView alloc] initWithFrame:frame] autorelease];
	view.tag = VIEW_TAG;
	
	frame.size.width = width - offset;
	UILabel *subLabel = [[UILabel alloc] initWithFrame:frame];
	subLabel.textAlignment = UITextAlignmentLeft;
	subLabel.backgroundColor = [UIColor clearColor];
	subLabel.font = [UIFont boldSystemFontOfSize:20.0];
	subLabel.userInteractionEnabled = NO;
	
	subLabel.tag = SUB_LABEL_TAG;
	
	[view addSubview:subLabel];
	[subLabel release];
	return view;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
	UIView *returnView = nil;
    NSArray *array = nil;
    NSString *text = [NSString stringWithFormat:@"Do Not Show"];
    
    if (component == 0)
    {
        if (self.profileflag == HEIGHT || self.profileflag == SPOUSEHEIGHT)
        {
            returnView = [self labelCellWithWidth:135 rightOffset:0];
        } else
        {
            returnView = [self labelCellWithWidth:270 rightOffset:0];
        }
    } else if (component == 1)
    {
        returnView = [self labelCellWithWidth:135 rightOffset:0];
    }
        
    UILabel *theLabel = nil;
    if (returnView.tag == VIEW_TAG) {
        theLabel = (UILabel *)[returnView viewWithTag:SUB_LABEL_TAG];
    }
    else {
        theLabel = (UILabel *)returnView;
    }
    
	// The text shown in the component is just the number of the component.
    switch (self.profileflag)
    {
        case AGE:
        case SPOUSEAGE:
            if (row == 0)
            {
                text = [NSString stringWithFormat:@"Do Not Show"];
            } else {
                text = [NSString stringWithFormat:@"%d", row+17];
            }
            theLabel.text = text;
            break;
        case LOOKFOR:
            array = [NSArray arrayWithObjects:@"Do Not Show", @"One Night", @"Long Relationship", @"Friends", nil];
            text = [NSString stringWithFormat:@"%@", [array objectAtIndex:row]];
            theLabel.text = text;
            break;
        case SPOUSEWEIGHT:
        case WEIGHT:
            if (row == 0)
            {
                text = [NSString stringWithFormat:@"Do Not Show"];
            } else {
                text = [NSString stringWithFormat:@"%d lbs", row+99];
            }
            theLabel.text = text;
            break;
        case SPOUSEHEIGHT:
        case HEIGHT:
            if (component == 0)
            {
                array = [NSArray arrayWithObjects:@"5 feet", @"6 feet", @"7 feet", nil];
                if (row == 0)
                {
                    text = [NSString stringWithFormat:@"Do Not Show"];
                } else {
                    text = [NSString stringWithFormat:@"%@", [array objectAtIndex:row-1]];
                }
                theLabel.text = text;
            } else
            {
                text = [NSString stringWithFormat:@"%d inches", row];
                theLabel.text = text;
            }
            break;
        default:
            break;
    }
    
	// Where to set the text in depends on what sort of view it is.

    //theLabel.textAlignment = UITextAlignmentLeft;
	return returnView;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	// If the user chooses a new row, update the label accordingly.
    //[self setRowSelected:row];
}

- (IBAction)cancel:(id)sender {
    [delegate cancel];
}

- (IBAction)saveText:(id)sender {
    
    int row = [self.pickerview selectedRowInComponent:0];
    int row2;
    NSArray *array = nil;
    switch (self.profileflag)
    {
        case AGE:
        case SPOUSEAGE:
            if (row == 0)
            {
                [delegate saveText:@"0" profile:self.profileflag];
            }else
            {
                [delegate saveText:[NSString stringWithFormat:@"%d",row+17] profile:self.profileflag];
            }
            break;
        case LOOKFOR:
            array = [NSArray arrayWithObjects:@"Do Not Show", @"One Night", @"Long Relationship", @"Friends", nil];
            [delegate saveText:[NSString stringWithFormat:@"%@",[array objectAtIndex:row]] profile:self.profileflag];
            break;
        case WEIGHT:
        case SPOUSEWEIGHT:
            if (row == 0)
            {
                [delegate saveText:@"0" profile:self.profileflag];
            }else
            {
                [delegate saveText:[NSString stringWithFormat:@"%d lbs",row+99] profile:self.profileflag];
            }
            break;
        case HEIGHT:
        case SPOUSEHEIGHT:
            row2 = [self.pickerview selectedRowInComponent:1];
            array = [NSArray arrayWithObjects:@"5'", @"6'", @"7'", nil];
            if (row == 0)
            {
                [delegate saveText:@"0" profile:self.profileflag];
            }else
            {
                [delegate saveText:[NSString stringWithFormat:@"%@%d\"",[array objectAtIndex:row-1], row2] profile:self.profileflag];
            }
            break;
        default:
            break;
    }
}

@end
