//
//  TWRUserFeedViewController.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRBaseViewController.h"
#import <UIKit/UIKit.h>

/**
 @abstract View controller used to display "twitter" feed where user can see own tweets.
 @discussion This view controller loads the tweets that are written to a local datastore, then load remote (new tweets).
 If new tweets exist view controller will show "refresh button" and will reload feed data if selection is made. This
 view controller doesn't perform an actual remote-local data synchronization.
 For demonstration purposes it doesn't account for the fact if user has previously deleted application (local storage is
 gone).
 */
@interface TWRFeedViewController : TWRBaseViewController

@end
