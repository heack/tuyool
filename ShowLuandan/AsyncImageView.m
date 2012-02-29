//
//  AsyncImageView.m
//  GoodBaby
//
//  Created by Jim on 10-3-10.
//  Copyright 2010. All rights reserved.
//

#import "AsyncImageView.h"

#define LOADING_VIEW_TAG 10
@implementation UrlImagePair

@synthesize url=_url;
@synthesize image=_image;

-(UrlImagePair*)initWithUrl:(NSURL*)url image:(UIImage*)image
{
	if(self == [super init])
	{		 
		self.url = url;
		self.image = image;
	}
	
	return self;
}

-(void)dealloc
{
	[super dealloc];
	[_url release];
	[_image release];
}

@end


@implementation AsyncImageView

static NSMutableArray* imageCache;

+(void)initialize
{
	if(nil == imageCache)
	{
		imageCache = [[NSMutableArray alloc] init];
	}
}

+(UIImage*)FindImageFromCache:(NSURL*)_url
{
	for(int index = 0; index < [imageCache count]; index ++)
	{
		UrlImagePair* pair = [imageCache objectAtIndex:index];
		NSString* saved =[pair.url absoluteString];
		NSString* find = [_url absoluteString];
		if( NSOrderedSame ==[saved compare:find options:NSCaseInsensitiveSearch])
		{
			return pair.image;
		}
	}
	
	return nil;
}

-(void)AddImageToCache:(UIImage*) image
{
	if(nil ==[AsyncImageView FindImageFromCache:imageUrl])
	{
		if([imageCache count] > MAX_CACHE_NUMBER)
		{  
			[imageCache removeObjectAtIndex:0];
		}
		
		UrlImagePair* pair = [[UrlImagePair alloc] initWithUrl:imageUrl image:image];
		[imageCache addObject:pair];
		[pair release];
	}
}

-(AsyncImageView*)initWithFrame:(CGRect)frame
{
	if(self == [super initWithFrame:frame])
	{
		self.contentMode = UIViewContentModeScaleAspectFit;
		self.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
	}
	
	return self;
}

-(AsyncImageView*)init
{
	if(self == [super init])
	{
		self.contentMode = UIViewContentModeScaleAspectFit;
		self.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
       
	}
	
	return self;
}

- (NSURL*) imageUrl
{
	return imageUrl;
}

- (void)setImageUrl:(NSURL*)url
{
	if([[url absoluteString] compare:[imageUrl absoluteString]] != NSOrderedSame)
	{
        UIImage *defaultImg = [UIImage imageNamed:@"default_head_img.jpg"];
        [self setImage:defaultImg];
		if (connection!=nil) 
		{
			[connection release];
			connection = nil;
		}
		
		if (data!=nil)
		{ 
			[data release];
			data = nil;
		}
		   
		[url retain];
		[imageUrl release];
		imageUrl = url;
		
		UIImage* image = [AsyncImageView FindImageFromCache:url];
		if(image != nil)
		{
			self.image = image; 
		}
		else
		{
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [activityIndicator setCenter:CGPointMake (self.frame.size.width/2, self.frame.size.height/2)];
            [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [self addSubview:activityIndicator];
            [activityIndicator startAnimating];
            
			NSURLRequest* request = [NSURLRequest requestWithURL:url
													 cachePolicy:NSURLRequestUseProtocolCachePolicy
												 timeoutInterval:Conection_Timeout];
			connection = [[NSURLConnection alloc]
						  initWithRequest:request delegate:self];		
		}
	}
}


- (void)connection:(NSURLConnection *)theConnection
	didReceiveData:(NSData *)incrementalData 
{
    if (data==nil) 
	{
		data =[[NSMutableData alloc] initWithCapacity:16384];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    [connection release];
    connection=nil;
	UIImage* image = [[UIImage alloc] initWithData:data];
	[data release];
	data=nil;
    
//	UIImageView *loadingView = (UIImageView*)[self viewWithTag:LOADING_VIEW_TAG];
//    [loadingView removeFromSuperview];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
	if(image != nil)
	{
	    [self AddImageToCache:image];	
	    self.image = image;
	    [image release];
	}
    
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error 
{
	NSLog(@"AsyncImageView Connection failed..  url:%@ \r\n error:%@", imageUrl, [error localizedDescription]);
	[connection release];
    connection=nil;
}

- (void)dealloc 
{
	[super dealloc];
    [connection release];
    [data release];
	[imageUrl release];
}

@end
