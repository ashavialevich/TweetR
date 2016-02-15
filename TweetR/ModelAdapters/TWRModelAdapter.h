//
//  TWRModelAdapter.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRCDTweet.h"
#import "TWRTweet.h"
#import "TWRTweetViewModel.h"
#import <Foundation/Foundation.h>

/**
 @abstract Model adapter class.
 @discussion This class is designed to abstract the domain models-to-view models conversion away from core data client
 and web service client. TWRModelAdapter does all the "heavy lifting" for the models conversion. The goal is to add all
 of the model conversions to this class, so that application doesn't have to worry about converting underlying models to
 view models and if underlying models were to ever change, you'd only need to update the implementation of these
 bindings. Application is only dealing with the view models that it needs to display. For the purpose of the exercise I
 only added the bindings I needed. It is not a comprehensive model adapter.
 */
@interface TWRModelAdapter : NSObject

/**
 @abstact Method to convert TWRCDTweet core data model to TWRTweetViewModel view model.
 @param coreDataTweet Core data model of type TWRCDTweet to be converted to view model of type TWRTweetViewModel.
 @return Returns a resulting converted view model of TWRTweetViewModel type.
 */
+ (TWRTweetViewModel *)tweetViewModelFromCoreDataTweet:(TWRCDTweet *)coreDataTweet;

/**
 @abstact Method to convert TWRTweet parse data model to TWRTweetViewModel view model.
 @param parseTweet Parse data model of type TWRTweet to be converted to view model of type TWRTweetViewModel.
 @return Returns a resulting converted view model of TWRTweetViewModel type.
 */
+ (TWRTweetViewModel *)tweetViewModelFromParseTweet:(TWRTweet *)parseTweet;

@end
