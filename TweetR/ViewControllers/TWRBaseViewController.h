//
//  TWRBaseViewController.h
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @abstract Base class to be inheritted by app's view controllers to get some of the common functionality.
 @discussion This class may be suitable as a utility class that view controllers can use and they wouldn't have to
 subclass this particular class and get common functionaly, but I decided to keep it the way it is and that can be
 revisited later.
 */
@interface TWRBaseViewController : UIViewController

/**
 @abstact Method used to push a view controller with the specified class onto the navigation stack, if current view
 controller is not nested inside UINavigationController this method will do nothing.
 */
- (void)pushViewController:(Class)vcClass;

/**
 @abstact Method used to present a view controller with the specified class with a default modal transition.
 */
- (void)presentViewcontroller:(Class)vcClass;

/**
 @abstract Method to display generic alert view controller.
 */
- (void)showGenericErrorAlertView;

/**
 @abstract Method to display alert view controller with specified title and message, only default action with title "OK"
 will be added to the alert.
 @param title Alert title.
 @param message Alert message.
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

/**
 @abstract Convenience method to assemble button with the specified image to be used as a custom view for navigation bar
 button items.
 */
- (UIButton *)buttonWithImage:(UIImage *)image;

/**
 @abstract Method to display black transparent overlay.
 @discussion This method will be used to display black transparent overlay while application is performing long running
 tasks on the background thread. User will not be able to interact with UI in the meantime. This is not great user
 experience, but the point is that the main thread is, however, is not blocked. Normally application will show a loading
 indicator and still allow for user interaction. This is just for demo purposes.
 */
- (void)displayOverLay;

/**
 @abstract Method to hide loading overlay view.
 */
- (void)hideOverlay;

@end
