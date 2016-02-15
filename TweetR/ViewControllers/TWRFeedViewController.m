//
//  TWRUserFeedViewController.m
//  TweetR
//
//  Created by Alex Shavialevich on 2/6/16.
//  Copyright © 2016 Alex Shavialevich. All rights reserved.
//

#import "TWRCoreDataClient.h"
#import "TWRErrorHandler.h"
#import "TWRFeedViewController.h"
#import "TWRTweet.h"
#import "TWRTweetViewController.h"
#import "TWRTweetViewModel.h"
#import "TWRUIConstants.h"
#import "TWRUserFeedTableViewCell.h"
#import "TWRWebServiceClient.h"

static NSString *const USER_FEED_CELL_NIB_NAME = @"TWRUserFeedTableViewCell";
static NSString *const USER_FEED_CELL_REUSE_IDENTIFIER = @"TWRUserFeedTableViewCell";
static NSString *const TWEET_ICON_IMAGE_NAME = @"tweet_icon";
static NSString *const TWEETER_LOGO_BLUE_IMAGE_NAME = @"tweeter_logo_blue";
static CGFloat const USER_FEED_TABLE_ESTIMATED_HEIGHT = 100.0f;
static CGFloat const REFRESH_BUTTON_OFFSET = 8.0f;
static NSTimeInterval const ANIMATION_DURATION = 0.7;

@interface TWRFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *refreshButtonOffsetConstraint;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;
@property (strong, nonatomic) IBOutlet UITableView *userFeedTableView;
@property (strong, nonatomic) NSArray<TWRTweetViewModel *> *tweetViewModels;
@property (strong, nonatomic) NSArray<TWRTweetViewModel *> *remoteTweets;

@end

@implementation TWRFeedViewController

#pragma mark - View Controller Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    self.refreshButton.layer.cornerRadius = TWR_BUTTON_CORNER_RADIUS;
    UIButton *button = [self buttonWithImage:[UIImage imageNamed:TWEET_ICON_IMAGE_NAME]];
    [button addTarget:self
                  action:@selector (rightNavigationBarButtonClicked)
        forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tweeter_logo_blue"]];
    [self configureTableView];
    NSArray<TWRTweetViewModel *> *tweets = [TWRCoreDataClient getLocalTweets];
    self.tweetViewModels = tweets;
    [TWRWebServiceClient markTweetsAsRead:tweets];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    __weak __typeof__(self) weakSelf = self;
    [TWRWebServiceClient getRemoteTweets:^(NSArray<TWRTweetViewModel *> *_Nullable tweets, NSError *_Nullable error) {
      if (error) {
          // we will just silently fail here for demo purposes
          return;
      }
      if (tweets.count > 0) {
          weakSelf.remoteTweets = tweets;
          [weakSelf displayRefreshFeed];
      }
    }];
}

#pragma mark - UITableViewDatasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TWRUserFeedTableViewCell *cell =
        [self.userFeedTableView dequeueReusableCellWithIdentifier:USER_FEED_CELL_REUSE_IDENTIFIER
                                                     forIndexPath:indexPath];
    TWRTweetViewModel *tweet = self.tweetViewModels[indexPath.row];
    cell.usernameLabel.text = tweet.username;
    cell.tweetContentLabel.text = tweet.tweetContent;
    return cell;
}

#pragma mark - Instance Methods

- (void)configureTableView {
    self.userFeedTableView.delegate = self;
    self.userFeedTableView.dataSource = self;
    self.userFeedTableView.estimatedRowHeight = USER_FEED_TABLE_ESTIMATED_HEIGHT;
    self.userFeedTableView.rowHeight = UITableViewAutomaticDimension;
    [self.userFeedTableView registerNib:[UINib nibWithNibName:USER_FEED_CELL_NIB_NAME bundle:nil]
                 forCellReuseIdentifier:USER_FEED_CELL_REUSE_IDENTIFIER];
}

- (void)rightNavigationBarButtonClicked {
    TWRTweetViewController *destinationVC = [[TWRTweetViewController alloc] init];
    [self presentViewController:destinationVC animated:YES completion:nil];
}

- (void)displayRefreshFeed {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                       self.refreshButtonOffsetConstraint.constant
                           = self.navigationController.navigationBar.frame.size.height +
                             [UIApplication sharedApplication].statusBarFrame.size.height + REFRESH_BUTTON_OFFSET;
                       [self.view layoutIfNeeded];
                     }];
}

- (void)hideRefreshFeed {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5
                     animations:^{
                       self.refreshButtonOffsetConstraint.constant = -self.refreshButton.frame.size.height;
                       [self.view setNeedsLayout];
                       [self.view layoutIfNeeded];
                     }];
}

#pragma mark - IBActions

- (IBAction)refreshClick:(UIButton *)sender {
    [self hideRefreshFeed];
    for (TWRTweetViewModel *tweet in self.remoteTweets) {
        [TWRCoreDataClient createTweet:tweet];
    }
    self.tweetViewModels = [self.remoteTweets arrayByAddingObjectsFromArray:self.tweetViewModels];
    [self.userFeedTableView reloadData];
    [TWRWebServiceClient markTweetsAsRead:self.remoteTweets];
}

@end
