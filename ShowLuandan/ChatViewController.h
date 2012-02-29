//
//  ChatViewController.h
//  SwingLife
//
//  Created by kong yang on 11-10-6.
//  Copyright 2011年 Crosslife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, UINavigationControllerDelegate>
{
    int maxId;
    NSTimer *timer;
    NSString *selfId;
    NSString *targetId;
    NSMutableArray		*chatArray;
}

-(void) onTimer;
@property (nonatomic, copy) NSString *selfId;
@property (nonatomic, copy) NSString *targetId;
@property (nonatomic, retain) NSTimer *timer;

- (void) loadChatFromServer;
- (BOOL) loadMoreChatFromServer;
-(void) sendChatInfo:(NSString*) word isAsync:(BOOL) isAsyn;
- (UIView *)bubbleView:(NSString *)text date:(NSString*)date from:(BOOL)fromSelf;
@end
