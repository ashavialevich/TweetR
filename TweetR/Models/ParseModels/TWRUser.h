//
//  TWRUser.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <Parse/Parse.h>

@interface TWRUser : PFUser

@property (strong, nonatomic) NSString *username;

@end
