//
//  EditProfileViewController.m
//  ShowLuandan
//
//  Created by kong yang on 11-9-24.
//  Copyright 2011年 Crosslife. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "EditProfileViewController.h"
#import "TypeSomethingViewController.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "ChooseImageActionSheet.h"
#import "UISinglePickerController.h"

@implementation EditProfileViewController

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
#define NAME 10

@synthesize headImgAndNameCellView;
@synthesize data;
@synthesize dataPath;
@synthesize headAndNameCellNib;
@synthesize userProfile;
int clear = 0;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    NSLog(@"received Memory Warning! in EditProfileViewController");
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"load in EditProfile View Controller ViewDidLoad");
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setHeadImgAndNameCellView:nil];
    [self setDataPath:nil];
    [self setUserProfile:nil];
    inited = NO;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!inited) {
        UIImage *backgroundImage = [UIImage imageNamed:@"table_background@2.png"];
        UIImageView *tableabckgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        [self.tableView setBackgroundView:tableabckgroundView];
        
        self.navigationItem.title = @"Edit Profile";
        [self setDataPath:[[NSBundle mainBundle] pathForResource:@"profiles" ofType:@"plist"]];
        [self setData:[NSMutableDictionary dictionaryWithContentsOfFile:self.dataPath]];
        [self setHeadAndNameCellNib:[UINib nibWithNibName:@"EditProfileHeadImageAndNameCellView" bundle:nil]];
        
        if (self.userProfile == nil) {
            CustomNavigationController *nagController = (CustomNavigationController*)self.navigationController;
            [self setUserProfile:nagController.userProfile];
        }
        inited = YES;
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if (section == 1)
    {
        return @"Edit Profile";
    } else if (section == 2) 
    {
        return @"Account Settings";
    } else if (section == 3)
    {
        return @"Delete Profile";
    } else
    {
        return nil;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Retur  the number of rows in the section.
    int rows = 0;
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 1:
            rows = 9;
            break;
        case 2:
            rows = 1;
            break;
        case 3:
            rows = 1;
            break;
        default:
            rows = 0;
            break;
    }
    return rows;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 90;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"EditProfile";
    static NSString *headImageAndName = @"headImageAndName";
    UITableViewCell *retcell = nil;
    if (indexPath.section == 0 && indexPath.row == 0) {
        EditProfileHeadImageAndNameCellView *cell = (EditProfileHeadImageAndNameCellView*)[tableView dequeueReusableCellWithIdentifier:headImageAndName];
        if (cell == nil || clear == 1) {
            [self.headAndNameCellNib instantiateWithOwner:self options:nil];
            cell = self.headImgAndNameCellView;
            self.headImgAndNameCellView = nil;
        }
        if (self.userProfile.userName != nil) {
            cell.nameLabel.text = self.userProfile.userName;
        }
        cell.headImageView.layer.masksToBounds = YES;
        cell.headImageView.layer.cornerRadius = 4;
        cell.rightView.layer.cornerRadius = 4;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.userProfile.userHeadImage != nil) {
            cell.headImageView.image = self.userProfile.userHeadImage;
        }
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 90.0f)];
        backgroundView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = backgroundView;
        [backgroundView release];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        retcell = cell;
        
    } else if (indexPath.section == 1)
    {
        static NSString *cellIdentifier2 = @"EditProfile2";
        CustomTableViewCell *cell = (CustomTableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        
        if (cell == nil || clear == 1) {
            cell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2] autorelease];
            [cell setUserProfile:self.userProfile];
            [cell saveName:indexPath.row];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        retcell = cell;
        
    } /*else if (indexPath.section == 2 && indexPath.row == 1) 
    {
        static NSString *cellIdentifier4 = @"EditProfile4";
        CustomTableViewCell *cell = (CustomTableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
        
        if (cell == nil || clear == 1) {
            cell = [[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier4] autorelease];
            [cell saveName:9];            
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        retcell = cell;
    } */else
    {
        static NSString *cellIdentifier3 = @"EditProfile3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        
        if (cell == nil || clear == 1) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3] autorelease];    
            if (indexPath.section == 2 && indexPath.row == 0) {
                cell.textLabel.text = @"Show Distance";
                UISwitch *distanceSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                if (self.userProfile.showDistance == nil) {
                    [distanceSwitch setOn:YES animated:YES];
                    [self.userProfile setShowDistance:@"1"];
                } else {
                    if ([self.userProfile.showDistance intValue] == 1) {
                        [distanceSwitch setOn:YES animated:YES];
                    } else {
                        [distanceSwitch setOn:NO animated:YES];
                    }
                }
                
                [distanceSwitch addTarget:self action:@selector(distanceShow:) forControlEvents:(UIControlEventValueChanged)];
                cell.accessoryView = distanceSwitch;
                [distanceSwitch release];
            }
            
            if (indexPath.section == 3) {
                UIButton *deleteProfile = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
                UILabel *deleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 14, 250, 20)];
                deleteLabel.text = @"Delete your profile";
                deleteLabel.font = [UIFont boldSystemFontOfSize:18];
                [deleteProfile addSubview:deleteLabel];
                [deleteProfile addTarget:self action:@selector(deleteProfile:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:deleteProfile];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        retcell = cell;
    }
    
    // Configure the cell...
    
    return retcell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    //UIViewController *converterController = nil;
    
    switch ([indexPath section]) {
        case 1:
            if (indexPath.row == 0)
            {
                TypeSomethingViewController *typeView =[[TypeSomethingViewController alloc]initWithNibName:@"TypeSomethingViewController" bundle:nil];
                typeView.delegate = self;
                [typeView setProfileflag:INTRO];
                [self presentModalViewController:typeView animated:YES];
            } 
            if (indexPath.row == 2)
            {
                TypeSomethingViewController *typeView =[[TypeSomethingViewController alloc]initWithNibName:@"TypeSomethingViewController" bundle:nil];
                typeView.delegate = self;
                [typeView setProfileflag:LOCATION];
                [self presentModalViewController:typeView animated:YES];
            }
            if (indexPath.row == 3)
             {
                 UISinglePickerController *typeView = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                 //converterController = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                 typeView.delegate = self;
                 [typeView setProfileflag:AGE];
                 UIViewController *controller = self.view.window.rootViewController;
                 controller.modalPresentationStyle = UIModalPresentationCurrentContext;
                 [self presentModalViewController:typeView animated:YES];
             }
            if (indexPath.row == 1)
            {
                UISinglePickerController *typeView = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                //converterController = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                typeView.delegate = self;
                [typeView setProfileflag:LOOKFOR];
                UIViewController *controller = self.view.window.rootViewController;
                controller.modalPresentationStyle = UIModalPresentationCurrentContext;
                [self presentModalViewController:typeView animated:YES];
            }
            if (indexPath.row == 4)
            {
                UISinglePickerController *typeView = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                //converterController = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                typeView.delegate = self;
                [typeView setProfileflag:HEIGHT];
                UIViewController *controller = self.view.window.rootViewController;
                controller.modalPresentationStyle = UIModalPresentationCurrentContext;
                [self presentModalViewController:typeView animated:YES];
            }
            if (indexPath.row == 5)
            {
                UISinglePickerController *typeView = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                //converterController = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                typeView.delegate = self;
                [typeView setProfileflag:WEIGHT];
                UIViewController *controller = self.view.window.rootViewController;
                controller.modalPresentationStyle = UIModalPresentationCurrentContext;
                [self presentModalViewController:typeView animated:YES];
            }
            if (indexPath.row == 6)
            {
                UISinglePickerController *typeView = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                //converterController = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                typeView.delegate = self;
                [typeView setProfileflag:SPOUSEAGE];
                UIViewController *controller = self.view.window.rootViewController;
                controller.modalPresentationStyle = UIModalPresentationCurrentContext;
                [self presentModalViewController:typeView animated:YES];
            }
            if (indexPath.row == 7)
            {
                UISinglePickerController *typeView = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                //converterController = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                typeView.delegate = self;
                [typeView setProfileflag:SPOUSEHEIGHT];
                UIViewController *controller = self.view.window.rootViewController;
                controller.modalPresentationStyle = UIModalPresentationCurrentContext;
                [self presentModalViewController:typeView animated:YES];
            }
            if (indexPath.row == 8)
            {
                UISinglePickerController *typeView = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                //converterController = [[UISinglePickerController alloc] initWithNibName:@"UISinglePickerController" bundle:nil];
                typeView.delegate = self;
                [typeView setProfileflag:SPOUSEWEIGHT];
                UIViewController *controller = self.view.window.rootViewController;
                controller.modalPresentationStyle = UIModalPresentationCurrentContext;
                [self presentModalViewController:typeView animated:YES];
            }
            break;
            
        default:
            break;
    }
    
}


//protocal typesomethingviewcontrollerdelegate
-(void) saveText: (NSString*) text profile:(int)flag
{
    if (flag == INTRO)
    {
        NSIndexPath *indexPathFor01 = [NSIndexPath indexPathForRow:0 inSection:1];
        CustomTableViewCell *cell01 = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPathFor01];
        cell01.detailLabel.text = text;
        [self.userProfile saveIntroduction:text];
    } else if (flag == LOCATION)
    {
        NSIndexPath *indexPathFor21 = [NSIndexPath indexPathForRow:2 inSection:1];
        CustomTableViewCell *cell21 = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPathFor21];
        cell21.detailLabel.text = text;
        [self.userProfile saveLocation:text];
    } else if (flag == NAME)
    {
        NSIndexPath *indexPathFor00 = [NSIndexPath indexPathForRow:0 inSection:0];
        EditProfileHeadImageAndNameCellView *cell00 = (EditProfileHeadImageAndNameCellView*)[self.tableView cellForRowAtIndexPath:indexPathFor00];
        cell00.nameLabel.text = text;
        [self.userProfile saveUserName:text];
    } else if (flag == AGE)
    {
        NSIndexPath *indexPathFor31 = [NSIndexPath indexPathForRow:3 inSection:1];
        CustomTableViewCell *cell31 = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPathFor31];
        if ([text intValue] == 0)
        {
            cell31.detailLabel.text = @"Do Not Show";
            [self.userProfile clearAge];
        }else
        {
            cell31.detailLabel.text = text;
            [self.userProfile saveAge:text];
        }
    } else if (flag == LOOKFOR)
    {
        NSIndexPath *indexPathFor11 = [NSIndexPath indexPathForRow:1 inSection:1];
        CustomTableViewCell *cell11 = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPathFor11];
        if (text == @"Do Not Show")
        {
            cell11.detailLabel.text = @"Do Not Show";
            [self.userProfile clearLookingFor];
        }else
        {
            cell11.detailLabel.text = text;
            [self.userProfile saveLookingFor:text];
        }
    } else if (flag == HEIGHT)
    {
        NSIndexPath *indexPathFor41 = [NSIndexPath indexPathForRow:4 inSection:1];
        CustomTableViewCell *cell41 = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPathFor41];
        if ([text intValue] == 0)
        {
            cell41.detailLabel.text = @"Do Not Show";
            [self.userProfile clearHeight];
        }else
        {
            cell41.detailLabel.text = text;
            [self.userProfile saveHeight:text];
        }
    } else if (flag == WEIGHT)
    {
        NSIndexPath *indexPathFor51 = [NSIndexPath indexPathForRow:5 inSection:1];
        CustomTableViewCell *cell51 = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPathFor51];
        if ([text intValue] == 0)
        {
            cell51.detailLabel.text = @"Do Not Show";
            [self.userProfile clearWeight];
        }else
        {
            cell51.detailLabel.text = text;
            [self.userProfile saveWeight:text];
        }
    } else if (flag == SPOUSEAGE)
    {
        NSIndexPath *indexPathFor61 = [NSIndexPath indexPathForRow:6 inSection:1];
        CustomTableViewCell *cell61 = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPathFor61];
        if ([text intValue] == 0)
        {
            cell61.detailLabel.text = @"Do Not Show";
            [self.userProfile clearSpouseage];
        }else
        {
            cell61.detailLabel.text = text;
            [self.userProfile saveSpouseage:text];
        }
    } else if (flag == SPOUSEHEIGHT)
    {
        NSIndexPath *indexPathFor71 = [NSIndexPath indexPathForRow:7 inSection:1];
        CustomTableViewCell *cell71 = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPathFor71];
        if ([text intValue] == 0)
        {
            cell71.detailLabel.text = @"Do Not Show";
            [self.userProfile clearSpouseheight];
        }else
        {
            cell71.detailLabel.text = text;
            [self.userProfile saveSpouseheight:text];
        }
    } else if (flag == SPOUSEWEIGHT)
    {
        NSIndexPath *indexPathFor81 = [NSIndexPath indexPathForRow:8 inSection:1];
        CustomTableViewCell *cell81 = (CustomTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPathFor81];
        if ([text intValue] == 0)
        {
            cell81.detailLabel.text = @"Do Not Show";
            [self.userProfile clearSpouseweight];
        }else
        {
            cell81.detailLabel.text = text;
            [self.userProfile saveSpouseweight:text];
        }
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void) cancel
{
    [self dismissModalViewControllerAnimated:YES];
}


//AsyHttpRequest delegate method;
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"finished");
    // Use when fetching text data
    //NSString *responseString = [request responseString];
    
    // Use when fetching binary data
    //NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"failed");
    //NSError *error = [request error];
}

- (IBAction)inputName:(id)sender {
    TypeSomethingViewController *typeView =[[TypeSomethingViewController alloc]initWithNibName:@"TypeSomethingViewController" bundle:nil];
    typeView.delegate = self;
    [typeView setProfileflag:NAME];
    [self presentModalViewController:typeView animated:YES];
}

- (IBAction)modifyHeadImage:(id)sender {
    //ChooseImageActionSheet *chooseHeadImageActionSheet = [[ChooseImageActionSheet alloc] initWithFrame:CGRectMake(0, 20, 320, 240)];
    UIActionSheet *chooseHeadImageActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose from existing pictures",@"Take Photo", nil];
    [chooseHeadImageActionSheet setDelegate:self];
    [chooseHeadImageActionSheet showInView:self.navigationController.view];
    [chooseHeadImageActionSheet release];
}
//protocal UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet.title == @"Delete") {
        if (buttonIndex == 0) {
            [self deleteMyProfile];
        }
    } else {
        if (buttonIndex == 0) {
            [self pickImageFromPhotoLibrary];
        } else if (buttonIndex == 1) {
            [self pickImageByTakingPhoto];
        }
    }
}
//end protocal UIActionSheetDelegate

-(void)pickImageFromPhotoLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

-(void)pickImageByTakingPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissModalViewControllerAnimated:YES];
    NSIndexPath *indexPathFor00 = [NSIndexPath indexPathForRow:0 inSection:0];
    EditProfileHeadImageAndNameCellView *cell00 = (EditProfileHeadImageAndNameCellView*)[self.tableView cellForRowAtIndexPath:indexPathFor00];
    [cell00.headImageView setImage:image];
    [self.userProfile saveUserHeadImage:image];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

//User Profile Delegate
-(void) showErrorMessage: (NSString*) errmsg
{
    NSLog(errmsg);
}
//User Profile Delegate End

-(void) dealloc
{
    [userProfile release];
    [dataPath release];
    [data release];
    [headImgAndNameCellView release];
    [headAndNameCellNib release];
    [super dealloc];
}

-(void) deleteMyProfile
{
    [self.userProfile clearProfile];
    clear = 1;
    [self.tableView reloadData];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)deleteProfile:(id)sender {
    UIActionSheet *deleteProfileActionSheet = [[UIActionSheet alloc] initWithTitle:@"Delete" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Delete", nil];
    [deleteProfileActionSheet setDelegate:self];
    [deleteProfileActionSheet showInView:self.navigationController.view];
    [deleteProfileActionSheet release];
}

- (IBAction)distanceShow:(id)sender
{   
    UISwitch *Switch = (UISwitch *)sender;
    if ([Switch isOn] == YES)
    {
        [self.userProfile saveShowDistance:@"1"];
    }
    else
    {
        [self.userProfile saveShowDistance:@"0"];
    }
}

- (IBAction)editAge:(id)sender
{   
    //UIButton *editAge = (UIButton *)sender;
}

@end
