//
//  TWRWebServiceClient.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/7/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRTweet.h"
#import "TWRTweetViewModel.h"
#import "TWRUser.h"
#import <Foundation/Foundation.h>

/**
 @abstract Completion handler invoked upon response for a simple success-error scenario.
 @param succeeded Boolean flag indicating whether request has succeded or not.
 @param error Request error if any.
 */
typedef void (^TWRSucceededHandler) (BOOL succeeded, NSError *__nullable error);

/**
 @abstract Completion handler invoked upon response for the getting user's tweet's request.
 @param tweets User's tweets.
 @param error Request error if any.
 */
typedef void (^TWRUserTweetsHandler) (NSArray<TWRTweetViewModel *> *__nullable tweets, NSError *__nullable error);

/**
 @abstract Web service client protocol.
 @discussion This protocol is designed to loosely couple web service client implementation from it's concrete
 implementation. In our case to abstract from parse client implementation.
 */
@protocol TWRWebServiceClientProtocol <NSObject>

/**
 @abstract Method used to do the preparation work for the service client to function properly. In our case TWRWebService
 concrete implementation will install parse hooks and register appropriate parse subclasses.
 */
+ (void)installWebHooks;

/**
 @abstact Method that web service client will use sign up a new user.
 @param username New account's username.
 @param password New account's password.
 @param email New account't email.
 @param handler Completion handler that will be invoked upon request comletion.
 */
+ (void)signupWithUsername:(nonnull NSString *)username
                  password:(nonnull NSString *)password
                     email:(nonnull NSString *)email
                   handler:(nonnull TWRSucceededHandler)handler;

/**
 @abstact Method that web service client will use sign in an existing user.
 @param username User account's username.
 @param password User account's password.
 @param handler Completion handler that will be invoked upon request comletion.
 */
+ (void)signInWithUsername:(nonnull NSString *)username
                  password:(nonnull NSString *)password
                   handler:(nonnull TWRSucceededHandler)handler;

/**
 @abstract Method used to all the remote (unread) tweet for the currently logged in user.
 @param handler Completion handler that will be invoked upon request comletion.
 */
+ (void)getRemoteTweets:(nonnull TWRUserTweetsHandler)handler;

/**
 @abstract Method used to post a new tweet.
 @discussion This method will make a service call and save new tweet with a proper user relation to remote DB.
 @param tweet TWRTweet type object with all the necessary information that will be posted.
 @param handler Completion handler that will be invoked upon request comletion.
 */
+ (void)postTweet:(nonnull TWRTweet *)tweet handler:(nonnull TWRSucceededHandler)handler;

/**
 @abstract Method used to mark passed in tweets of type TWRTweet as read.
 @discussion This method kicks off and completes on the background thred. There are no particular error checking
 implemented, so in case of error this method would fail to mark tweets as read in the remote DB. Production code should
 not allow for that.
 */
+ (void)markTweetsAsRead:(nonnull NSArray<TWRTweetViewModel *> *)tweets;

@end

/**
 @abstract Service used to make all remote services requests that application needs.
 @discussion This class was designed to abstract from the internal implementation of the service client. Right now it
 uses TWRParseClient class to make calls to the remote parse.com DB. This abstraction layer was added so that internal
 client could be swapped/changed without affecting application logic. All you would need to do is to create a new class
 that conforms to TWRWebServiceClientProtocol protocol, guaranteeing to implement all the necessary call for the app.
 */
@interface TWRWebServiceClient : NSObject <TWRWebServiceClientProtocol>

@end
