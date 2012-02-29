//
//  AsyncImageView.h
//  GoodBaby
//
//  Created by Jim on 10-3-10.
//  Copyright 2010. All rights reserved.
//

// This is a ImageView that can load the image from a url asynchronsly. And by default we cache max to 100 pictures
// in the memory.

#import <Foundation/Foundation.h>

#define MAX_CACHE_NUMBER 100
#define Conection_Timeout 40 // in seconds

@interface UrlImagePair : NSObject
{
@private
	NSURL * _url;
	UIImage * _image;
}

@property (nonatomic, retain) NSURL * url;
@property (nonatomic, retain) UIImage * image;

@end


@interface AsyncImageView : UIImageView {

@private
	NSURLConnection* connection;
    NSMutableData* data;
	NSURL* imageUrl;
}

- (NSURL*) imageUrl;
- (void)setImageUrl:(NSURL*)url;

@end
