//
//  HelloScene.m
//  FlyBird
//
//  Created by Andrew Torres on 3/4/14.
//  Copyright (c) 2014 J.Tech. All rights reserved.
//

#import "GameOver.h"
#import "LevelOne.h"
#import "HelloScene.h"
#import "GameData.h"

@implementation GameOver : SKScene

- (void)didMoveToView: (SKView *) view {
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void) birdNode {
    SKSpriteNode *birdNode = [SKSpriteNode spriteNodeWithImageNamed:@"Squid.png"];
    birdNode.name= @"homeBird";
    birdNode.size = CGSizeMake(self.frame.size.height/4, self.frame.size.height/4);
    birdNode.position = CGPointMake(self.frame.size.width*.25,self.frame.size.height*.55);
    [self addChild:birdNode];
    SKAction *up = [SKAction moveByX:0 y:18 duration:1];
    SKAction *down = [SKAction moveByX:0 y:-18 duration:1];
    SKAction *seq = [SKAction sequence:@[up, down]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    [birdNode runAction:rep];
}

-(void)gameoverNode {
    SKLabelNode *gameoverlabel = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    gameoverlabel.name = @"gameoverlabel";
    gameoverlabel.fontSize = self.frame.size.height/10;
    gameoverlabel.fontColor = [SKColor redColor];
    gameoverlabel.text = @"GAME OVER";
    gameoverlabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - gameoverlabel.frame.size.height*1.25);
    [self addChild:gameoverlabel];
}


- (void) highscoreNode {
    SKLabelNode *highscorelabel = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    highscorelabel.name = @"highscorelabel";
    highscorelabel.fontColor = [SKColor whiteColor];
    highscorelabel.fontSize = self.frame.size.height/18;
    highscorelabel.text = [NSString stringWithFormat:@"High Score: %ld", [GameData sharedGameData].highScore];
    highscorelabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height-highscorelabel.frame.size.height*4);
    [self addChild:highscorelabel];
}

- (void) scoreNode {
    SKLabelNode *endscore = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    endscore.name = @"endscore";
    endscore.fontColor = [SKColor whiteColor];
    endscore.fontSize = self.frame.size.height/18;
    endscore.text =[NSString stringWithFormat:@"Score: %ld", [GameData sharedGameData].score];
    endscore.position = CGPointMake(CGRectGetMidX(self.frame),self.frame.size.height-endscore.frame.size.height*5.25);
    [self addChild:endscore];
}



- (void) coinLabelNode {
    SKLabelNode *totalcoincountlabel = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    totalcoincountlabel.name = @"totalcoinlabel";
    totalcoincountlabel.fontColor = [SKColor whiteColor];
    totalcoincountlabel.fontSize = self.frame.size.height/20;
    totalcoincountlabel.position = CGPointMake(CGRectGetMidX(self.frame),self.frame.size.height*.2175);
    totalcoincountlabel.text = [NSString stringWithFormat:@"Coins: %ld", [GameData sharedGameData].coins];
    [self addChild:totalcoincountlabel];
}

- (void) replayNode
{
    SKSpriteNode *replay = [SKSpriteNode spriteNodeWithImageNamed:@"replaybutton.png"];
    replay.name = @"replayButton";
    replay.size = CGSizeMake(self.frame.size.height/5.8, self.frame.size.height/5.8);
    replay.position = CGPointMake(self.frame.size.width*.7,self.frame.size.height*.55);
    [self addChild:replay];
}

- (void) lifeNode {
    SKLabelNode *life = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    life.name = @"life";
    life.text = [NSString stringWithFormat:@"Lives: %ld", [GameData sharedGameData].lives];
    life.fontColor = [SKColor whiteColor];
    life.fontSize = self.frame.size.height/20;
    life.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height*.145);
    [self addChild:life];
}

-(void) twentyfive {
    SKLabelNode *twentyfive = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    twentyfive.name = @"twentyfive";
    twentyfive.text = @"(25 coins)";
    twentyfive.fontColor = [SKColor whiteColor];
    twentyfive.fontSize = self.frame.size.height/30;
    twentyfive.position = CGPointMake(twentyfive.frame.size.width/2 + 10, self.frame.size.height *.145);
    [self addChild:twentyfive];
}

-(void) addLife {
    SKSpriteNode *addlife = [SKSpriteNode spriteNodeWithImageNamed:@"add.png"];
    addlife.scale = .4;
    addlife.name = @"addlife";
    addlife.position = CGPointMake(CGRectGetMidX(self.frame)*3/2, self.frame.size.height*.165);
    [self addChild:addlife];
}

- (void) mainMenuNode
{
    SKSpriteNode *homeNode = [SKSpriteNode spriteNodeWithImageNamed:@"home_icon.png"];
    homeNode.name = @"mainmenu";
    homeNode.scale = .24;
    homeNode.position = CGPointMake(self.frame.size.width*.25, self.frame.size.height*.35);
    [self addChild:homeNode];
}

-(void)leaderNode
{
    SKSpriteNode *leaderNode = [SKSpriteNode spriteNodeWithImageNamed:@"leaderboard_icon.png"];
    leaderNode.name = @"leaderNode";
    leaderNode.scale = .45;
    leaderNode.position = CGPointMake(self.frame.size.width*.5, self.frame.size.height*.35);
    [self addChild:leaderNode];
}

-(void)soundNode
{
    SKSpriteNode *soundNode = [SKSpriteNode spriteNodeWithImageNamed:@"sound_icon.png"];
    soundNode.name = @"soundNode";
    soundNode.scale = .24;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"soundToggle"] isEqual: @"OFF"]) {
        soundNode.alpha = .5;
    }
    soundNode.position = CGPointMake(self.frame.size.width*.75, self.frame.size.height*.35);
    [self addChild:soundNode];
}

- (void) backgroundNode1
{
    SKSpriteNode *backgroundNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg_1.png"];
    backgroundNode1.name=@"gameoverbg1";
    backgroundNode1.anchorPoint = CGPointZero;
    backgroundNode1.position = CGPointMake(0, 0);
    backgroundNode1.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:backgroundNode1];
}

- (void) backgroundNode2
{
    SKSpriteNode *backgroundNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"bg_1.png"];
    backgroundNode2.name=@"gameoverbg2";
    backgroundNode2.anchorPoint = CGPointZero;
    backgroundNode2.position = CGPointMake(self.frame.size.width - 1, 0);
    backgroundNode2.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:backgroundNode2];
}


- (void)createSceneContents {
    self.scaleMode = SKSceneScaleModeResizeFill;
    [self backgroundNode1];
    [self backgroundNode2];
    [self birdNode];
    [self highscoreNode];
    [self scoreNode];
    [self coinLabelNode];
    [self mainMenuNode];
    [self replayNode];
    [self lifeNode];
    [self gameoverNode];
    [self leaderNode];
    [self soundNode];
    [self addLife];
    [self twentyfive];
    
    SKAction *up = [SKAction moveByX:0 y:18 duration:1];
    SKAction *down = [SKAction moveByX:0 y:-18 duration:1];
    SKAction *seq = [SKAction sequence:@[up, down]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    SKNode *squid = [self childNodeWithName:@"birdNode"];
    [squid runAction:rep];
    
}

-(void)update:(NSTimeInterval)currentTime
{
    SKNode *back1 = (SKSpriteNode *)[self childNodeWithName:@"gameoverbg1"];
    SKNode *back2 = (SKSpriteNode *)[self childNodeWithName:@"gameoverbg2"];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        /*UITouch* touch = [touches anyObject];*/
        CGPoint loc = [touch locationInNode:self];
        SKNode *start = [self childNodeWithName:@"replayButton"];
        SKNode *lead = [self childNodeWithName:@"leaderNode"];
        SKNode *mainmenu = [self childNodeWithName:@"mainmenu"];
        SKNode *buylife = [self childNodeWithName:@"addlife"];
        SKNode *volume = [self childNodeWithName:@"soundNode"];
        if([lead containsPoint:loc])
        {
            [[GameKitHelper sharedGameKitHelper] presentLeaderboardsOnViewController:self.view.window.rootViewController];
        }
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
        if([mainmenu containsPoint:loc])
        {
            SKAction *moveUp = [SKAction moveByX: 0 y: 10 duration: 0.30];
            SKAction *pause = [SKAction waitForDuration: 0.2];
            SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
            SKAction *remove = [SKAction removeFromParent];
            SKAction *moveSequence = [SKAction sequence:@[moveUp, pause, fadeAway, remove]];
            [mainmenu runAction: moveSequence completion:^{
                SKScene *homeScene  = [[HelloScene alloc] initWithSize:self.size];
                [self.view presentScene:homeScene];
            }];;
        }
        if([buylife containsPoint:loc])
        {
            SKAction *moveUp = [SKAction moveByX: 0 y: 10 duration: 0.30];
            SKAction *moveDown = [SKAction moveByX:0 y:-10 duration:.30];
            SKAction *moveSequence = [SKAction sequence:@[moveUp, moveDown]];
            [buylife runAction: moveSequence];
            if ([GameData sharedGameData].coins >= 25 && [GameData sharedGameData].lives < 3)
            {
                [GameData sharedGameData].coins -=25;
                [GameData sharedGameData].lives += 1;
                [[GameData sharedGameData] save];
                SKLabelNode *life = (SKLabelNode *) [self childNodeWithName:@"life"];
                life.text = [NSString stringWithFormat:@"Lives: %ld", [GameData sharedGameData].lives];
                
                SKLabelNode *coins = (SKLabelNode *) [self childNodeWithName:@"totalcoinlabel"];
                coins.text = [NSString stringWithFormat:@"Coins: %ld", [GameData sharedGameData].coins];
            }
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
@end