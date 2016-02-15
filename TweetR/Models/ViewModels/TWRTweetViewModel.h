//
//  TWRTweetViewModel.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 @abstract View model class representing a tweet.
 @discussion This view model (although it's the only one in the app) was created so that consuming view controllers are
 dealing with entirely abstracted implementation of the underlying models (core data models, parsed models coming back
 from the web service etc.). That way if underlying implementation of retrieving those models ever changes, there will
 be no need to modify view controllers' logic as they will be treating their models exactly the same way.
 */
@interface TWRTweetViewModel : NSObject

/**
 @abstract Internal convenience property to get reference to the underlying parse.com object. View controller's
 interpretation of the model is independent of that property.
 */
@property (strong, nonatomic, readonly) NSString *parseID;

/**
 @abstract Tweet user's ID.
 */
@property (strong, nonatomic, readonly) NSString *userID;

/**
 @abstract Tweet user's username.
 */
@property (strong, nonatomic, readonly) NSString *username;

/**
 @abstract Tweet's content.
 */
@property (strong, nonatomic, readonly) NSString *tweetContent;

/**
 @abstract Tweet creation date.
 */
@property (strong, nonatomic, readonly) NSDate *tweetDate;

/**
 @abstract Creates a new instance of TWRTweetViewModel class based on the passed parameters.
 @param parseID Internal convenience property to get reference to the underlying parse.com object. View controller's
 interpretation of the model is independent of that property.
 @param userID Tweet user's ID.
 @param username Tweet user's username.
 @param tweetContent Tweet's content.
 @return Returns a new instance of TWRTweetViewModel class based on the passed parameters.
 */
- (instancetype)initWithParseID:(NSString *)parseID
                         userID:(NSString *)userID
                       username:(NSString *)username
                   tweetContent:(NSString *)tweetContent
                      tweetDate:(NSDate *)tweetDate;

@end
