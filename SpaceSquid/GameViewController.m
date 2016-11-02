//
//  GameViewController.m
//  SpaceSquid
//
//  Created by Andrew Torres on 10/19/14.
//  Copyright (c) 2014 Andrew Torres. All rights reserved.
//

#import "GameViewController.h"
#import "HelloScene.h"
#import "GameData.h"
#import "GameKitHelper.h"

@interface GameViewController()
{
    //IAD
    bool adOnTop;
    bool iAdsBannerIsVisible;
    
    ADBannerView *banner;
}
@end

@implementation GameViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveSoundNotification:)
                                                 name:@"SoundNotification"
                                               object:nil];

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(showAuthenticationVC)
     name:PresentAuthenticationViewController
     object:nil];
    
    [[GameKitHelper sharedGameKitHelper]
     authenticateLocalPlayer];
}

- (void) receiveSoundNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"SoundNotification"])
        NSLog (@"Successfully received the test notification!");
    if ([_aplayer isPlaying]) {
        [_aplayer pause];
    }
    else {
        [_aplayer play];
    }
}

- (void)showAuthenticationVC
{
    GameKitHelper *gameKitHelper =
    [GameKitHelper sharedGameKitHelper];
    
    [self.navigationController.topViewController presentViewController:
     gameKitHelper.authenticationVC
                                         animated:YES
                                       completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // test to see if its okay to show iAds... if so, call...
    if (!self.contentCreated) {
        self.contentCreated = YES;
         [self showThinBanner];
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"gamemusic"
                                         ofType:@"mp3"]];
        _aplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _aplayer.numberOfLoops = -1;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"ON" forKey:@"soundToggle"];
        [_aplayer play];
    
    
    }
   
    SKView * skView = (SKView*)self.view;
    if (!skView.scene) {
        skView.showsFPS = NO;
        skView.showsNodeCount =
        NO;
        skView.showsPhysics = NO;
        SKScene * scene = [HelloScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:scene];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [banner removeFromSuperview];
    banner.delegate = nil;
    banner = nil;
}

-(void) showThinBanner {
    iAdsBannerIsVisible = YES;
    banner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    [banner setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    banner.delegate = self;
    UIView *view = self.view;
    banner.frame = CGRectMake(0, view.frame.size.height - banner.frame.size.height, banner.frame.size.width, banner.frame.size.height);
    [self.view addSubview:banner];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)ban{
    NSLog(@"Banner has loaded");
    iAdsBannerIsVisible = YES;
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    UIView *view = self.view;
    ban.frame = CGRectMake(0, view.frame.size.height - ban.frame.size.height, ban.frame.size.width, ban.frame.size.height);
    [UIView commitAnimations];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Banner view is beginning an ad action");
    BOOL shouldExecuteAction = YES; // your app implements this method if (!willLeave && shouldExecuteAction){
    // insert code here to suspend any services that might conflict with the advertisement, for example, you might pause the game with an NSNotification like this...
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PauseScene" object:nil]; //optional

    return shouldExecuteAction;
}

-(void) bannerViewActionDidFinish:(ADBannerView *)banner {
    NSLog(@"banner is done being fullscreen");
    //Unpause the game if you paused it previously.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UnPauseScene" object:nil]; //optional
}

- (void)bannerView:(ADBannerView *)ban didFailToReceiveAdWithError:(NSError *)error
{
    if (iAdsBannerIsVisible == YES) {
        
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        ban.frame = CGRectOffset(ban.frame, 0, ban.frame.size.height);
        [UIView commitAnimations];
        iAdsBannerIsVisible = NO;
        
        NSLog(@"banner unavailable");
    }
}
//call this method to remove adds yourself... not recommended by apple

-(void) removeAds{
    if (iAdsBannerIsVisible == YES)  {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        iAdsBannerIsVisible = NO;
        NSLog(@"hiding banner");
        [banner cancelBannerViewAction];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskLandscape;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



@end
