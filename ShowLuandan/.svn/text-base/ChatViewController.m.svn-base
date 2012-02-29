//
//  ChatViewController.m
//  SwingLife
//
//  Created by kong yang on 11-10-6.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import "ChatViewController.h"
#import "ASIFormDataRequest.h"
#import "Base64.h"
#import "SBJson.h"

@implementation ChatViewController

#define TEXTFIELDTAG	100
#define TOOLBARTAG		200
#define TABLEVIEWTAG	300
#define LOADINGVIEWTAG	400

@synthesize selfId;
@synthesize targetId;
@synthesize timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
	if(self = [super init]) {
		UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
		self.view = contentView;
		[contentView release];
		
		chatArray = [[NSMutableArray alloc] initWithCapacity:0];
		
		UITextField *textfield = [[[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 31.0f)] autorelease];
		textfield.tag = TEXTFIELDTAG;
		textfield.delegate = self;
		textfield.autocorrectionType = UITextAutocorrectionTypeNo;
		textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
		textfield.enablesReturnKeyAutomatically = YES;
		textfield.borderStyle = UITextBorderStyleRoundedRect;
		textfield.returnKeyType = UIReturnKeySend;
		textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 372.0f, 320.0f, 44.0f)];
		toolBar.tag = TOOLBARTAG;
		NSMutableArray* allitems = [[NSMutableArray alloc] init];
		[allitems addObject:[[[UIBarButtonItem alloc] initWithCustomView:textfield] autorelease]];
		[toolBar setItems:allitems];
		[allitems release];
		[self.view addSubview:toolBar];
		[toolBar release];
		
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 372.0f) style:UITableViewStylePlain];
		tableView.delegate = self;
		tableView.dataSource = self;
		tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		tableView.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
		tableView.tag = TABLEVIEWTAG;
		[self.view addSubview:tableView];
		[tableView release];
        
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
- (UIView *)bubbleView:(NSString *)text date:(NSString*)date from:(BOOL)fromSelf {
	// build single chat bubble cell with given text
	UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
	returnView.backgroundColor = [UIColor clearColor];
	
	UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"bubbleSelf":@"bubble" ofType:@"png"]];
	UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
	
	UIFont *font = [UIFont systemFontOfSize:13];
	CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(200.0f, 1000.0f) lineBreakMode:  UILineBreakModeWordWrap];
	int minwidth = 20;
    if (size.width>minwidth) {
        minwidth = size.width;
    }
	UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 13.0f, minwidth, size.height)];
    if(fromSelf){
        bubbleText.frame = CGRectMake(250.0f-minwidth-10.0f, 13.0f, minwidth, size.height);
        
    }
	bubbleText.backgroundColor = [UIColor clearColor];
	bubbleText.font = font;
	bubbleText.numberOfLines = 0;
	bubbleText.lineBreakMode = UILineBreakModeWordWrap;
	bubbleText.text = text;
	
    UIFont *datefont = [UIFont systemFontOfSize:11];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, size.height+15.0f, 250, 21)];
    if(fromSelf)
        dateLabel.frame = CGRectMake(0, size.height+15.0f, 245, 21);
    dateLabel.backgroundColor = [UIColor clearColor];
	dateLabel.font = datefont;
	dateLabel.numberOfLines = 0;
	dateLabel.lineBreakMode = UILineBreakModeWordWrap;
    dateLabel.textColor = [UIColor grayColor];
	dateLabel.text = date;
    if(fromSelf) {
        dateLabel.textAlignment = UITextAlignmentRight;
    } else {
        dateLabel.textAlignment = UITextAlignmentLeft;
    }
    
    if (fromSelf)
        bubbleImageView.frame = CGRectMake(250.0f-minwidth-20.0f, 10.0f, minwidth+20.0f, size.height+10.0f);
    else
        bubbleImageView.frame = CGRectMake(0.0f, 10.0f, minwidth+20.0f, size.height+10.0f);
    
	if(fromSelf)
		//returnView.frame = CGRectMake(320.0f-minwidth-20.0f, 0.0f, minwidth+30, size.height+30.0f);
        returnView.frame = CGRectMake(320.0f-250.0f, 0.0f, 250, size.height+40.0f);
	else
		//returnView.frame = CGRectMake(0.0f, 0.0f, minwidth+30.0f, size.height+30.0f);
        returnView.frame = CGRectMake(0.0f, 0.0f, 250, size.height+40.0f);
	[returnView addSubview:bubbleImageView];
	[bubbleImageView release];
	[returnView addSubview:bubbleText];
    [returnView addSubview:dateLabel];
    [dateLabel release];
	[bubbleText release];
	
	return [returnView autorelease];
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    

}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![chatArray count]) {
        
        [self loadChatFromServer];
    }
    [self setTimer:[NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES]];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    [self setTimer:nil];
}

-(void) viewDidAppear:(BOOL)animated
{
    UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
    [tableView reloadData];
    if ([chatArray count]) {
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}



- (BOOL) hideKeyboard {
	UITextField *textField = (UITextField *)[self.view viewWithTag:TEXTFIELDTAG];
	if(textField.editing) {
		textField.text = @"";
		[self.view endEditing:YES];
		
		return YES;
	}
	
	return NO;
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


//table protocal

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chatArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *chatInfo = [chatArray objectAtIndex:[indexPath row]];
    UIView *chatView = nil;
    if (![chatInfo objectForKey:@"view"]) {
        NSString *speaker = [chatInfo objectForKey:@"speaker"];
        NSString *date = [chatInfo objectForKey:@"date"];
        chatView = [self bubbleView:[NSString stringWithFormat:@"%@", [chatInfo objectForKey:@"text"]] date:date from:[speaker isEqualToString:@"self"]?YES:NO];
        [chatInfo setObject:chatView forKey:@"view"];
    } else {
        chatView = [chatInfo objectForKey:@"view"];
    }
	return chatView.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"chatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];	
		cell.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSMutableDictionary *chatInfo = [chatArray objectAtIndex:[indexPath row]];
    if (![chatInfo objectForKey:@"view"]) {
        NSString *speaker = [chatInfo objectForKey:@"speaker"];
        NSString *date = [chatInfo objectForKey:@"date"];
        UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@", [chatInfo objectForKey:@"text"]]  date:date from:[speaker isEqualToString:@"self"]?YES:NO];
        [chatInfo setObject:chatView forKey:@"view"];
    }
	for(UIView *subview in [cell.contentView subviews])
		[subview removeFromSuperview];
	[cell.contentView addSubview:[chatInfo objectForKey:@"view"]];
    return cell;
}

//table protocal end


//text field protocal

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	// return NO to disallow editing.
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"hideKeyboard", nil)
                                                                               style:UIBarButtonItemStyleBordered 
                                                                              target:self
                                                                              action:@selector(hideKeyboard)] autorelease];
    
	[UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
    
	UIToolbar *toolbar = (UIToolbar *)[self.view viewWithTag:TOOLBARTAG];
	toolbar.frame = CGRectMake(0.0f, 156.0f, 320.0f, 44.0f);
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	tableView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 156.0f);
	if([chatArray count])
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [UIView commitAnimations];
	
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    self.navigationItem.rightBarButtonItem = nil;
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:0.3];
	UIToolbar *toolbar = (UIToolbar *)[self.view viewWithTag:TOOLBARTAG];
	toolbar.frame = CGRectMake(0.0f, 372.0f, 320.0f, 44.0f);
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	tableView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 372.0f);
    [UIView commitAnimations];
	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// called when 'return' key pressed. return NO to ignore.
    //	self.navigationItem.leftBarButtonItem.title = @"save chat log";
    //	self.navigationItem.leftBarButtonItem.enabled = YES;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *now = [[NSDate alloc] init];
    NSString *theDate = [dateFormat stringFromDate:now];
    
	UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@", textField.text] date:theDate from:YES];
	//NSString *sendString=@"c:";
	//sendString=[sendString stringByAppendingString:textField.text];
	//[[Communicator sharedCommunicator]SendMsg:sendString];

	[chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:textField.text, @"text", @"self", @"speaker", chatView, @"view",theDate,@"date", nil]];
    [now release];
    [dateFormat release];
    
	UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
	[tableView reloadData];
	[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [self sendChatInfo:textField.text isAsync:NO];
    textField.text = @"";
	return YES;
}
//text field protocal end
-(void) sendChatInfo:(NSString*) word isAsync:(BOOL) isAsyn
{
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://swinglife.crosslife.com/chat.php?sourceid=%@&targetid=%@&method=post",self.selfId,self.targetId];
    NSURL *url = [[NSURL alloc]initWithString: urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:word  forKey:@"word"];
    [request setDelegate:self.navigationController];
    if (isAsyn) {
        [request startAsynchronous];
    } else {
        [request startSynchronous];
    }
    [urlString release];
    [url release];
}

- (void) loadChatFromServer
{
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://swinglife.crosslife.com/chat.php?sourceid=%@&targetid=%@&method=fetchtarget",self.selfId,self.targetId];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request startSynchronous];
    [urlString release];
    NSError *error = [request error];
    if (!error) {
        
        NSString *response = [request responseString];
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSArray *retarray = [jsonParser objectWithString:response];
        for (NSDictionary *chat in retarray) {
            NSString *id = [chat objectForKey:@"id"];
            int thisId = [id intValue];
            if (thisId>maxId) {
                maxId = thisId;
            }
            NSString *isself = [chat objectForKey:@"self"];
            NSString *speaker = nil;
            if ([isself isEqualToString:@"1"]) {
                speaker = @"self";
            } else {
                speaker = @"target";
            }
            NSString *word_base64_data = (NSString *)[chat objectForKey:@"word"];
            NSString *word = [Base64 decodeBaseWithString:word_base64_data];
            NSString *date = [chat objectForKey:@"date"];
            [chatArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys: word, @"text", speaker, @"speaker",date,@"date", nil]];
        }
        
        [jsonParser release];
    }
}

- (BOOL) loadMoreChatFromServer
{
    BOOL ret = NO;
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://swinglife.crosslife.com/chat.php?sourceid=%@&targetid=%@&method=fetchtargetmore&maxid=%d",self.selfId,self.targetId,maxId];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request startSynchronous];
    [urlString release];
    NSError *error = [request error];
    if (!error) {
        
        NSString *response = [request responseString];
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSArray *retarray = [jsonParser objectWithString:response];
        if (retarray!=nil && [retarray count] >0) {
            ret = YES;
            for (NSDictionary *chat in retarray) {
                NSString *id = [chat objectForKey:@"id"];
                int thisId = [id intValue];
                if (thisId>maxId) {
                    maxId = thisId;
                }
                NSString *isself = [chat objectForKey:@"self"];
                NSString *speaker = nil;
                if ([isself isEqualToString:@"1"]) {
                    speaker = @"self";
                } else {
                    speaker = @"target";
                }
                NSString *word_base64_data = (NSString *)[chat objectForKey:@"word"];
                NSString *word = [Base64 decodeBaseWithString:word_base64_data];
                NSString *date = [chat objectForKey:@"date"];
                [chatArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys: word, @"text", speaker, @"speaker",date,@"date", nil]];
            }
        }
        
        [jsonParser release];
        
    }
    return ret;
}



-(void) onTimer
{
    if([self loadMoreChatFromServer])
    {
        UITableView *tableView = (UITableView *)[self.view viewWithTag:TABLEVIEWTAG];
        [tableView reloadData];
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatArray count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
}


-(void) dealloc
{
    [timer release];
    [selfId release];
    [targetId release];
    [chatArray release];
    [super dealloc];
}

@end
