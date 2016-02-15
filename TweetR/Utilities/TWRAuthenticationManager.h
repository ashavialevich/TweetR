//
//  TWRAuthenticationManager.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @abstract Class used to "manage stack" based on the user's authentication status.
 @discussion This class is created to abstract proper landing page and handling user sign in/sign up results
 appropropriately. It doesn't do any actual user session management or complex navigation stack manipulation, but I
 wanted to abstract this functionality from individual view controllers in case this needs to be expanded on (production
 version of this class would have much more functionality in it.
 */
@interface TWRAuthenticationManager : NSObject

/**
 @abstract Method used to to handle application launch.
 @discussion On application launch determination needs to be made regarding user's authentication status in order to
 determine correct launch screen (whether to proceed to the authentication screen or proceed directly to the app in case
 user has already logged in).
 */
+ (void)handleAppLaunch;

/**
 @abstract Method used to navigate to a proper page after user sign up/sign in. Currently navigates to the user's feed
 page.
 */
+ (void)proceedToApp;

@end
