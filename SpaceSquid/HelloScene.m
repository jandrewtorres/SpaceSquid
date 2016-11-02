//
//  GameScene.m
//  SpaceSquid
//
//  Created by Andrew Torres on 10/19/14.
//  Copyright (c) 2014 Andrew Torres. All rights reserved.
//
#import "HelloScene.h"
#import "LevelOne.h"
#import "About.h"
#import "GameData.h"

@implementation HelloScene

- (void)didMoveToView: (SKView *) view {
    if (!self.contentCreated)
    {
        [SKAction repeatActionForever:[SKAction playSoundFileNamed:@"gamemusic.mp3" waitForCompletion:YES]];
        [self createSceneContents];
        self.contentCreated = YES;
    }
    
}

- (void) backgroundNode1
{
    SKSpriteNode *backgroundNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg_1.png"];
    backgroundNode1.name=@"homebg1";
    backgroundNode1.anchorPoint = CGPointZero;
    backgroundNode1.position = CGPointMake(0, 0);
    backgroundNode1.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:backgroundNode1];
}

- (void) backgroundNode2
{
    SKSpriteNode *backgroundNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"bg_1.png"];
    backgroundNode2.name=@"homebg2";
    backgroundNode2.anchorPoint = CGPointZero;
    backgroundNode2.position = CGPointMake(self.frame.size.width - 1, 0);
    backgroundNode2.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:backgroundNode2];
}

- (void) birdNode {
    SKSpriteNode *birdNode = [SKSpriteNode spriteNodeWithImageNamed:@"Squid.png"];
    birdNode.name= @"homeBird";
    birdNode.size = CGSizeMake(self.frame.size.height/4, self.frame.size.height/4);
    birdNode.position = CGPointMake(self.frame.size.width*.25,self.frame.size.height*.5);
    [self addChild:birdNode];
}
- (void) startNode {
    
    SKSpriteNode *ssnode = [SKSpriteNode spriteNodeWithImageNamed:@"sstitle.png"];
    ssnode.name=@"ssnode";
    ssnode.size = CGSizeMake(self.frame.size.width*1.25, self.frame.size.height);
    ssnode.position = CGPointMake(self.frame.size.width*.515, self.frame.size.height*.825);
    [self addChild:ssnode];
    
    SKSpriteNode *startNode = [SKSpriteNode spriteNodeWithImageNamed:@"playbutton.png"];
    startNode.name = @"startButton";
    startNode.size = CGSizeMake(startNode.size.width/2.5, startNode.size.height/2.5);
    startNode.position=CGPointMake(self.frame.size.width-startNode.frame.size.width/1.25,self.frame.size.height*.5);
    [self addChild:startNode];
    
    
    SKSpriteNode *leaderNode = [SKSpriteNode spriteNodeWithImageNamed:@"leaderboard_icon.png"];
    leaderNode.name = @"leaderNode";
    leaderNode.scale = .45;
    leaderNode.position = CGPointMake(self.frame.size.width/3, self.frame.size.height*.35);
    [self addChild:leaderNode];
    
    SKSpriteNode *volumeNode = [SKSpriteNode spriteNodeWithImageNamed:@"sound_icon.png"];
    volumeNode.name = @"volumeNode";
    volumeNode.scale = .24;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"soundToggle"] isEqual: @"OFF"]) {
        volumeNode.alpha = .5;
    }
    volumeNode.position = CGPointMake(self.frame.size.width/3*2, self.frame.size.height*.35);
    [self addChild:volumeNode];
    
    SKLabelNode *highscorelabel = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    highscorelabel.name = @"highscorelabel";
    highscorelabel.fontSize = self.frame.size.height/18;
    highscorelabel.fontColor = [SKColor whiteColor];
    highscorelabel.text = [NSString stringWithFormat:@"Best Score: %ld",[GameData sharedGameData].highScore] ;
    highscorelabel.position = CGPointMake(self.frame.size.width*.5, self.frame.size.height*.7);
    [self addChild:highscorelabel];
    
    SKLabelNode *coinslabel = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    coinslabel.name = @"coinslabel";
    coinslabel.fontSize = self.frame.size.height/20;
    coinslabel.fontColor = [SKColor whiteColor];
    coinslabel.text = [NSString stringWithFormat:@"Coins: %ld", [GameData sharedGameData].coins];
    coinslabel.position = CGPointMake(self.frame.size.width*.5, self.frame.size.height*.225);
    [self addChild:coinslabel];
    
    SKLabelNode *livesNode = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    livesNode.name = @"livesNode";
    livesNode.fontSize = self.frame.size.height/20;
    livesNode.fontColor = [SKColor whiteColor];
    livesNode.text = [NSString stringWithFormat:@"Lives: %ld", [GameData sharedGameData].lives];
    livesNode.position = CGPointMake(self.frame.size.width*.5, self.frame.size.height*.15);
    [self addChild:livesNode];
    
}

- (void)createSceneContents {
    self.scaleMode = SKSceneScaleModeResizeFill;
    [self backgroundNode1];
    [self backgroundNode2];
    [self startNode];
    [self birdNode];
    SKAction *up = [SKAction moveByX:0 y:18 duration:1];
    SKAction *down = [SKAction moveByX:0 y:-18 duration:1];
    SKAction *seq = [SKAction sequence:@[up, down]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    SKNode *squid = [self childNodeWithName:@"homeBird"];
    [squid runAction:rep];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        /*UITouch* touch = [touches anyObject];*/
        CGPoint loc = [touch locationInNode:self];
        SKNode *start = [self childNodeWithName:@"startButton"];
        SKNode *about = [self childNodeWithName:@"adfreeButton"];
        SKNode *lead = [self childNodeWithName:@"leaderNode"];
        SKNode *volume = [self childNodeWithName:@"volumeNode"];
        if([start containsPoint:loc])
        {
            SKAction *moveUp = [SKAction moveByX: 0 y: 10.0 duration: 0.30];
            SKAction *pause = [SKAction waitForDuration: 0.2];
            SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
            SKAction *remove = [SKAction removeFromParent];
            SKAction *moveSequence = [SKAction sequence:@[moveUp, pause, fadeAway, remove]];
            [start runAction: moveSequence completion:^{
                SKScene *levelOneScene  = [[LevelOne alloc] initWithSize:self.size];
                [self.view presentScene:levelOneScene];
            }];;
        }
        if([about containsPoint:loc])
        {
            SKAction *moveUp = [SKAction moveByX: 0 y: 10.0 duration: 0.30];
            SKAction *pause = [SKAction waitForDuration: 0.2];
            SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
            SKAction *remove = [SKAction removeFromParent];
            SKAction *moveSequence = [SKAction sequence:@[moveUp, pause, fadeAway, remove]];
            [about runAction: moveSequence completion:^{
                SKScene *aboutScene  = [[About alloc] initWithSize:self.size];
                [self.view presentScene:aboutScene];
            }];;
        }
        if([lead containsPoint:loc])
        {
            [[GameKitHelper sharedGameKitHelper] presentLeaderboardsOnViewController:self.view.window.rootViewController];
        }
        if([volume containsPoint:loc])
        {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"SoundNotification"
             object:self];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if([[defaults objectForKey:@"soundToggle"]  isEqual: @"ON"]) {
                SKAction *change = [SKAction fadeAlphaTo:.5 duration:.1];
                [volume runAction:change];
                [defaults setObject:@"OFF" forKey:@"soundToggle"];
            }
            else {
                SKAction *change2 = [SKAction fadeAlphaTo:1 duration:.1];
                [volume runAction:change2];
                [defaults setObject:@"ON" forKey:@"soundToggle"];
            }
        }
    }
}

-(void)dealloc
{
    NSLog(@"Exit main scene");
}

-(void)update:(NSTimeInterval)currentTime
{
    SKNode *back1 = (SKSpriteNode *)[self childNodeWithName:@"homebg1"];
    SKNode *back2 = (SKSpriteNode *)[self childNodeWithName:@"homebg2"];
    back1.position = CGPointMake(back1.position.x - 1, back1.position.y);
    back2.position = CGPointMake(back2.position.x - 1, back2.position.y);
    if (back1.position.x < -(self.frame.size.width))
    {
        back1.position = CGPointMake(back2.position.x + self.frame.size.width, back1.position.y);
    }
    
    if (back2.position.x < -(self.frame.size.width))
    {
        back2.position = CGPointMake(back1.position.x + self.frame.size.width, back2.position.y);
    }
    
}

@end
