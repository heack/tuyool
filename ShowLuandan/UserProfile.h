//
//  UserProfile.h
//  SwingLife
//
//  Created by kong yang on 11-9-28.
//  Copyright 2011年 Crosslife. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol UserProfileErrorDelegate <NSObject> 

-(void) showErrorMessage: (NSString*) errmsg;

@end

@interface UserProfile : NSObject
{
    NSString *userId;
    NSString *userName;
    UIImage *userHeadImage;
    NSString *dataPath;
    NSString *latitude;
    NSString *longitude;
    NSArray *nearbyUsers;
    NSArray *recentContacts;
    NSArray *favoriteUsers;
    NSString *showDistance;
    NSString *introduction;
    NSString *lookingFor;
    NSString *location;
    NSString *age;
    NSString *height;
    NSString *weight;
    NSString *spouseage;
    NSString *spouseweight;
    NSString *spouseheight;
    NSString *minage;
    NSString *maxage;
    
    int totalUnreadNum;
    NSMutableDictionary *data;
    id<UserProfileErrorDelegate> delegate;
    int isOnline;
    BOOL isOnlyShowOnlineUsers;
}
- (id)initWithDelegate: (id<UserProfileErrorDelegate>) delegater;
@property (nonatomic, copy) NSString *userId;
-(void) saveUserId:(NSString *)user_id;
@property (nonatomic, copy) NSString *userName;
-(void) saveUserName:(NSString *)user_name;
@property (nonatomic, retain) UIImage *userHeadImage;
-(void) saveUserHeadImage:(UIImage *)user_headImage;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
-(void) saveLongitude:(NSString *)p_longitude withLatitude:(NSString *)p_latitude;
@property (nonatomic, copy) NSString *showDistance;
-(void) saveShowDistance:(NSString *)show_distance;
@property (nonatomic, copy) NSString *introduction;
-(void) saveIntroduction:(NSString *)per_introduction;
-(void) clearIntroduction;
@property (nonatomic, copy) NSString *lookingFor;
-(void) saveLookingFor:(NSString *)per_lookingFor;
-(void) clearLookingFor;
@property (nonatomic, copy) NSString *location;
-(void) saveLocation:(NSString *)per_location;
-(void) clearLocation;
@property (nonatomic, copy) NSString *age;
-(void) saveAge:(NSString *) per_age;
-(void) clearAge;
@property (nonatomic, copy) NSString *minage;
-(void) saveMinage:(NSString *) per_minage;
-(void) clearMinage;
@property (nonatomic, copy) NSString *maxage;
-(void) saveMaxage:(NSString *) per_maxage;
-(void) clearMaxage;
@property (nonatomic, copy) NSString *height;
-(void) saveHeight:(NSString *)per_height;
-(void) clearHeight;
@property (nonatomic, copy) NSString *weight;
-(void) saveWeight:(NSString *)per_weight;
-(void) clearWeight;
@property (nonatomic, copy) NSString *spouseage;
-(void) saveSpouseage:(NSString *)per_spouseage;
-(void) clearSpouseage;
@property (nonatomic, copy) NSString *spouseheight;
-(void) saveSpouseheight:(NSString *)per_spouseheight;
-(void) clearSpouseheight;
@property (nonatomic, copy) NSString *spouseweight;
-(void) saveSpouseweight:(NSString *)per_spouseweight;
-(void) clearSpouseweight;

@property (assign) int totalUnreadNum;

@property (nonatomic, retain) NSArray *nearbyUsers;
@property (nonatomic, retain) NSArray *recentContacts;
@property (nonatomic, retain) NSArray *favoriteUsers;
@property (nonatomic) int isOnline;
@property (nonatomic) BOOL isOnlyShowOnlineUsers;
@property (nonatomic, copy) NSString *dataPath;
@property (nonatomic, retain) NSMutableDictionary *data;
@property (assign) id<UserProfileErrorDelegate> delegate;

-(void) sendProfileValueToServer:(NSString*) value withKey:(NSString*) key withInProfiles:(BOOL) inProfile asynchronous:(BOOL) isAsyn;
-(void) sendCustomJsonStringToServer:(NSString *)jsonString asynchronous:(BOOL) isAsyn;
-(void) clearProfile;
-(void) checkNewVersion;

-(NSString *)userName;
-(UIImage*) userHeadImage;
-(NSString *)latitude;
-(NSString *)longitude;
-(NSString *)introduction;
-(NSString *)lookingFor;
-(NSString *)location;
-(NSString *)age;
-(NSString *)minage;
-(NSString *)maxage;
-(NSString *)height;
-(NSString *)weight;
-(NSString *)spouseage;
-(NSString *)spouseheight;
-(NSString *)spouseweight;

-(NSArray*) getNearByUsers;
-(NSArray*) getRecentContacts;
-(NSArray*) getFavoriteUsers;
-(NSString *)showDistance;

-(void) addUserToFavorite:(NSString *) targetId;
-(void) removeUserFromFavorite:(NSString *) targetId;

-(void) setOnline;
-(void) setOffline;

-(NSString *) getTotalUnreadNum;

@end
