//
//  ViewUserProfileViewController.m
//  ShowLuandan
//
//  Created by kong yang on 11-9-19.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "ViewUserProfileViewController.h"
#import "EditProfileViewController.h"
#import "CustomSettingsCell.h"
@implementation ViewUserProfileViewController
@synthesize data;


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

- (void)viewWillAppear:(BOOL)animated
{
    UIImage *backgroundImage = [UIImage imageNamed:@"table_background@2.png"];
    UIImageView *tableabckgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    [self.tableView setBackgroundView:tableabckgroundView];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // Load data
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"settingsTableView" ofType:@"plist"];
    self.data = [NSArray arrayWithContentsOfFile:dataPath];
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

-(void) dealloc
{
    [data release];
    [super dealloc];
}

//protocol
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%d",self.data.count);
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.data objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"settings_cell";
    CustomSettingsCell *cell = (CustomSettingsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[CustomSettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        NSDictionary *dataItem = [[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        UIImage *img = [UIImage imageNamed:[dataItem objectForKey:@"icon"]];
        cell.imageView.image = img;
        cell.textLabel.text = [dataItem objectForKey:@"label"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataItem = [[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //SEL method = NSSelectorFromString([dataItem objectForKey:@"selector"]);
    NSString *nibName = [dataItem objectForKey:@"nibName"];
    [self showViewByNibName:nibName];
}
-(void) showViewByNibName : (NSString *) nibName
{
    //NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    
    //UITableViewController *view = [nib objectAtIndex:0];
    UITableViewController *view =[[NSClassFromString(nibName) alloc]initWithNibName:nibName bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}
@end
