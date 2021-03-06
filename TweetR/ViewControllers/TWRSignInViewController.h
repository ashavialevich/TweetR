//
//  TWRSignInViewController.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/7/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRBaseViewController.h"
#import <UIKit/UIKit.h>

/**
 @abstract View Controller used to display sign in screen.
 @discussion This class doesn't perform any email verification, but it performs basic form validation, such as presence
 of the required fields. This form should've probably been nested inside UIScrollView to accomodate better user
 experience on short screen and in landscape mode because of the keyboard overlap, but I omitted this part as I deemed
 it not important for the purposes of the coding exercise, if need be I can easily add this functionality. As of right
 not form is optimized for iPhone 6 and + in portrait mode.
 */
@interface TWRSignInViewController : TWRBaseViewController

@end
