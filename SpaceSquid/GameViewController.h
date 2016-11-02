//
//  GameViewController.h
//  SpaceSquid
//

//  Copyright (c) 2014 Andrew Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>
#import <GameKit/GameKit.h>
#import <AVFoundation/AVFoundation.h>


@interface GameViewController : UIViewController <ADBannerViewDelegate>

@property (nonatomic) AVAudioPlayer *aplayer;
@property BOOL contentCreated;
@end
