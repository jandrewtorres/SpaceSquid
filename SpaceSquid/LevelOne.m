//
//  LevelOne.m
//  FlyBird
//
//  Created by Andrew Torres on 3/4/14.
//  Copyright (c) 2014 J.Tech. All rights reserved.
//

#import "LevelOne.h"
#import "GameOver.h"
#import "GameData.h"

@implementation LevelOne : SKScene


#pragma mark declare/didMoveToView
// collision bitmasks
static const uint32_t planeCategory = 0x1 <<0;
static const uint32_t plane2Category = 0x1 << 4;
static const uint32_t plane3Category = 0x1 <<5;
static const uint32_t  birdCategory = 0x1 <<1;
static const uint32_t coinCategory = 0x1 <<3;


- (void)didMoveToView: (SKView *) view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
        self.contactQueue = [NSMutableArray array];
        self.physicsWorld.contactDelegate = self;
    }
}

#pragma mark addNodes
-(void) addCoin
{
    SKSpriteNode *coinNode = [SKSpriteNode spriteNodeWithImageNamed:@"finalcoin.png"];
    coinNode.scale = .1;
    coinNode.name=@"coin";
    coinNode.colorBlendFactor = .5;
    coinNode.color = [SKColor whiteColor];
    coinNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:8];
    coinNode.physicsBody.affectedByGravity = NO;
    coinNode.physicsBody.dynamic = YES;
    coinNode.physicsBody.usesPreciseCollisionDetection = NO;
    coinNode.physicsBody.categoryBitMask = coinCategory;
    coinNode.physicsBody.collisionBitMask = coinCategory;
    int minY = coinNode.size.height / 2;
    int maxY = self.frame.size.height-coinNode.size.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    coinNode.position = CGPointMake(self.frame.size.width, actualY);
    [self addChild:coinNode];
}

-(SKSpriteNode *) plane3Node
{
    SKSpriteNode *plane3Node = [SKSpriteNode spriteNodeWithImageNamed:@"Astroid1.png"];
    plane3Node.colorBlendFactor =.5;
    plane3Node.color = [SKColor purpleColor];
    plane3Node.size = CGSizeMake(self.frame.size.height/5.8, self.frame.size.height/5.8);
    plane3Node.name = @"plane3";
    plane3Node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(plane3Node.size.height/3,plane3Node.size.height/2)];
    plane3Node.anchorPoint = CGPointMake(.6,.5);
    plane3Node.physicsBody.affectedByGravity = NO;
    plane3Node.physicsBody.dynamic = YES;
    plane3Node.physicsBody.allowsRotation = NO;
    plane3Node.physicsBody.usesPreciseCollisionDetection = NO;
    plane3Node.physicsBody.categoryBitMask = plane3Category;
    plane3Node.physicsBody.collisionBitMask = plane3Category;
    int minY = plane3Node.size.height / 2;
    int maxY = self.frame.size.height-plane3Node.size.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    plane3Node.position = CGPointMake(self.frame.size.width, actualY);
    return plane3Node;
}

-(SKSpriteNode *) plane2Node
{
    SKSpriteNode *plane2Node = [SKSpriteNode spriteNodeWithImageNamed:@"RedAstroid2.png"];
    plane2Node.colorBlendFactor =.6;
    plane2Node.color = [SKColor redColor];
    plane2Node.size = CGSizeMake(self.frame.size.height/5.8, self.frame.size.height/5.8);
    plane2Node.name = @"plane2";
    plane2Node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(plane2Node.size.height/3.5,plane2Node.size.height/3.5)];
    plane2Node.anchorPoint = CGPointMake(.7,.4);
    plane2Node.physicsBody.affectedByGravity = NO;
    plane2Node.physicsBody.dynamic = YES;
    plane2Node.physicsBody.allowsRotation = NO;
    plane2Node.physicsBody.usesPreciseCollisionDetection = NO;
    plane2Node.physicsBody.categoryBitMask = plane2Category;
    plane2Node.physicsBody.collisionBitMask = plane2Category;
    int minY = plane2Node.size.height / 2;
    int maxY = self.frame.size.height-plane2Node.size.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    plane2Node.position = CGPointMake(self.frame.size.width, actualY);
    return plane2Node;
}

-(SKSpriteNode *) planeNode
{
    SKSpriteNode *planeNode = [SKSpriteNode spriteNodeWithImageNamed:@"Astroid2.png"];
    planeNode.colorBlendFactor =.0;
    planeNode.color = [SKColor yellowColor];
    planeNode.size = CGSizeMake(self.frame.size.height/5.8, self.frame.size.height/5.8);
    planeNode.name = @"plane";
    planeNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(planeNode.size.height/3.5,planeNode.size.height/3.5)];
    planeNode.anchorPoint = CGPointMake(.7,.4);
    planeNode.physicsBody.affectedByGravity = NO;
    planeNode.physicsBody.dynamic = YES;
    planeNode.physicsBody.allowsRotation = NO;
    planeNode.physicsBody.usesPreciseCollisionDetection = NO;
    planeNode.physicsBody.categoryBitMask = planeCategory;
    planeNode.physicsBody.collisionBitMask = planeCategory;
    planeNode.physicsBody.contactTestBitMask = planeCategory;
    int minY = planeNode.size.height / 2;
    int maxY = self.frame.size.height-planeNode.size.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    planeNode.position = CGPointMake(self.frame.size.width, actualY);
    return planeNode;
}

- (void) backgroundNode1
{
    SKSpriteNode *backgroundNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg_1.png"];
    backgroundNode1.name=@"lvl1bg1";
    backgroundNode1.anchorPoint = CGPointZero;
    backgroundNode1.position = CGPointMake(0, 0);
    backgroundNode1.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:backgroundNode1];
}

- (void) backgroundNode2
{
    SKSpriteNode *backgroundNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"bg_1.png"];
    backgroundNode2.name=@"lvl2bg2";
    backgroundNode2.anchorPoint = CGPointZero;
    backgroundNode2.position = CGPointMake(self.frame.size.width - 1, 0);
    backgroundNode2.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:backgroundNode2];
}

- (void) scoreNode
{
    SKLabelNode *scoreNode = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    scoreNode.name = @"scoreNode";
    scoreNode.fontColor = [SKColor whiteColor];
    scoreNode.fontSize = self.frame.size.height/30;
    scoreNode.text = [NSString stringWithFormat:@"Score: %li", [GameData sharedGameData].score];
    scoreNode.position=CGPointMake(self.frame.size.width - scoreNode.frame.size.width/1.5,self.frame.size.height - scoreNode.frame.size.height);
    [self addChild:scoreNode];
    
    SKLabelNode *coinNode = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    coinNode.name = @"coinNode";
    coinNode.fontColor = [SKColor whiteColor];
    coinNode.fontSize = self.frame.size.height/30;
    coinNode.text = [NSString stringWithFormat:@"Coins: %li", [GameData sharedGameData].levelCoins];
    coinNode.position=CGPointMake(coinNode.frame.size.width/2,self.frame.size.height - coinNode.frame.size.height);
    [self addChild:coinNode];
    
}
- (void) birdNode
{
    SKSpriteNode *birdNode = [SKSpriteNode spriteNodeWithImageNamed:@"Squid.png"];
    birdNode.name= @"bird";
    /*birdNode.scale = .1;*/
    birdNode.size = CGSizeMake(self.frame.size.height/10, self.frame.size.height/10);
    birdNode.position = CGPointMake(self.frame.size.width/3,self.frame.size.height/2);
    birdNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:birdNode.size.height/3.75];
    birdNode.physicsBody.mass = .05;
    birdNode.physicsBody.affectedByGravity = YES;
    birdNode.physicsBody.dynamic = YES;
    birdNode.physicsBody.allowsRotation = NO;
    birdNode.physicsBody.restitution = 0.0;
    birdNode.physicsBody.categoryBitMask = birdCategory;
    birdNode.physicsBody.contactTestBitMask = planeCategory | coinCategory | plane3Category | plane2Category;
    birdNode.physicsBody.collisionBitMask = birdCategory;
    [self addChild:birdNode];
}

-(void) tapStart
{
    SKLabelNode *tapStart = [SKLabelNode labelNodeWithFontNamed:@"Toonish"];
    tapStart.fontColor = [SKColor whiteColor];
    tapStart.name = @"tapstart";
    tapStart.fontSize = 22;
    tapStart.text =@"Tap to Start!";
    tapStart.position = CGPointMake(CGRectGetMaxX(self.frame)/2,CGRectGetMidY(self.frame)/2);
    [self addChild:tapStart];
    
}

-(void) lifeNode1
{
    SKSpriteNode *life1 = [SKSpriteNode spriteNodeWithImageNamed:@"Squid.png"];
    life1.name = @"life1";
    life1.scale = .075;
    life1.position = CGPointMake(CGRectGetMidX(self.frame)-life1.size.width,CGRectGetMaxY(self.frame)-life1.size.height/1.8);
    [self addChild:life1];
}

-(void) lifeNode2
{
    SKSpriteNode *life2 = [SKSpriteNode spriteNodeWithImageNamed:@"Squid.png"];
    life2.name = @"life2";
    life2.scale = .075;
    life2.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-life2.size.height/1.8);
    [self addChild:life2];
}

- (void) lifeNode3
{
    SKSpriteNode *life3 = [SKSpriteNode spriteNodeWithImageNamed:@"Squid.png"];
    life3.name = @"life3";
    life3.scale = .075;
    life3.position = CGPointMake(CGRectGetMidX(self.frame)+life3.size.width,CGRectGetMaxY(self.frame)-life3.size.height/1.8);
    [self addChild:life3];
}


-(void)endGame {
    //1
    if (!self.gameEnding)
    {
        self.gameEnding = YES;
        //High Score logic
        [GameData sharedGameData].highScore = MAX([GameData sharedGameData].score,
                                                    [GameData sharedGameData].highScore);
        [[GameData sharedGameData] save];
        [[GameKitHelper sharedGameKitHelper] reportScore];
        SKScene *gameOverScene  = [[GameOver alloc] initWithSize:self.size];
        [self.view presentScene:gameOverScene];
    }
}

#pragma mark createContents

- (void)createSceneContents
{
    [[GameData sharedGameData] reset];
    self.start = false;
    self.didcollide = false;
    self.didcoincollide = false;
    float bottomOffset = -35;
    self.physicsWorld.gravity = CGVectorMake(0, -3.8);
    CGRect newFrame = CGRectMake(-45, -bottomOffset, self.frame.size.width+50, self.frame.size.height+bottomOffset);
    // 1 Create a physics body that borders the screen
    SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:newFrame];
    // 2 Set physicsBody of scene to borderBody
    self.physicsBody = borderBody;
    // 3 Set the friction of that physicsBody to 0
    self.physicsBody.friction = 0.0f;
    self.backgroundColor = [SKColor darkGrayColor];
    self.scaleMode = SKSceneScaleModeResizeFill;
    [self backgroundNode1];
    [self backgroundNode2];
    [self tapStart];
    [self scoreNode];
    [self birdNode];
    self.inv_life = false;
    if ([GameData sharedGameData].lives == 3)
    {
        [self lifeNode1];
        [self lifeNode2];
        [self lifeNode3];
    }
    if ([GameData sharedGameData].lives == 2)
    {
        [self lifeNode1];
        [self lifeNode2];
    }
    if ([GameData sharedGameData].lives == 1)
    {
        [self lifeNode1];
    }
    
}

#pragma mark touchHandling

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKNode *birdNode = [self childNodeWithName:@"bird"];
    birdNode.physicsBody.velocity = CGVectorMake(0,0);
    SKAction *first = [SKAction setTexture:[SKTexture textureWithImageNamed:@"Squid2.png"]];
    SKAction *pause = [SKAction waitForDuration:.2];
    SKAction *newaction = [SKAction setTexture:[SKTexture textureWithImageNamed:@"Squid.png"]];
    SKAction *seq = [SKAction sequence:@[first,pause,newaction]];
    [birdNode runAction:seq];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"soundToggle"] isEqual:@"ON"]) {
        [self runAction:[SKAction playSoundFileNamed:@"jump.mp3" waitForCompletion:NO]]; //jmp snd
    }
    [birdNode.physicsBody applyImpulse:CGVectorMake(0, 13)];
    self.start=true;
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    if ([[touchedNode name] isEqualToString:@"replay"]) {
        //perform action here
        self.didcollide =false;
        self.didcoincollide = false;
        SKScene *redo = [[LevelOne alloc] initWithSize:self.size];
        SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
        [self.view presentScene:redo transition:doors];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

#pragma mark updates
- (void)updateWithTimeSinceLastCoin:(CFTimeInterval)timeSinceCoin
{
    self.lastCoinSpawnInterval += timeSinceCoin;
    if (self.lastCoinSpawnInterval > 2 )
    {
        self.lastCoinSpawnInterval=0;
        [self addCoin];
    }
    
}
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > .5 && [GameData sharedGameData].score <45) {
        self.lastSpawnTimeInterval = 0;
        [self addChild:[self planeNode]];
    }
    if (self.lastSpawnTimeInterval > 1.00 && [GameData sharedGameData].score>45)
    {
        self.lastSpawnTimeInterval = 0;
        [self addChild:[self planeNode]];
    }
    
}

- (void)updateWithTimeSinceLastPlane2:(CFTimeInterval)timeSinceLast2
{
    self.lastSpawn2TimeInterval += timeSinceLast2;
    if (self.lastSpawn2TimeInterval > 1.0)
    {
        self.lastSpawn2TimeInterval = 0;
        [self addChild: [self plane2Node]];
    }
}
- (void)updateWithTimeSinceLastPlane3:(CFTimeInterval)timeSinceLast3
{
    self.lastSpawn3TimeInterval += timeSinceLast3;
    if (self.lastSpawn3TimeInterval > 1.55)
    {
        self.lastSpawn3TimeInterval = 0;
        [self addChild: [self plane3Node]];
    }
}


-(void)updateWithTimeSinceDeath:(CFTimeInterval)timeSinceDie
{
    self.lastDeathSpawnInterval += timeSinceDie;
    if (self.lastDeathSpawnInterval > 1.5)
    {
        self.lastDeathSpawnInterval = 0;
        SKNode *squid = [self childNodeWithName:@"bird"];
        squid.physicsBody.categoryBitMask = birdCategory;
    }
}

- (void)update:(NSTimeInterval)currentTime {
    if(self.start)
    {
        SKNode *bird = (SKSpriteNode *)[self childNodeWithName:@"bird"];
        bird.physicsBody.affectedByGravity = YES;
        SKNode *start = (SKLabelNode *)[self childNodeWithName:@"tapstart"];
        [start removeFromParent];
        if (bird.position.y < 60) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([[defaults objectForKey:@"soundToggle"] isEqual:@"ON"]) {
                [self runAction:[SKAction playSoundFileNamed:@"lifelost.mp3" waitForCompletion:NO]];
            }
            if ([GameData sharedGameData].lives == 0)
            {
                self.didcollide = true;
                SKSpriteNode *bird =(SKSpriteNode *)[self childNodeWithName:@"bird"];
                bird.physicsBody.dynamic = NO;
                bird.physicsBody.affectedByGravity = NO;
                SKAction *hit = [SKAction moveToY:-20 duration:.7];
                SKAction *oop = [SKAction rotateByAngle:720 duration:2];
                SKAction *pause = [SKAction removeFromParent];
                SKAction *hitseq = [SKAction sequence:@[hit,pause]];
                [bird runAction:oop];
                [bird runAction:hitseq];
                self.gameEnding = NO;
                [self endGame];
            }
            else{
                [GameData sharedGameData].lives -=1;
                
                SKNode *liveSquid = [self childNodeWithName:@"bird"];
                SKAction *dis = [SKAction fadeOutWithDuration:.25];
                SKAction *app = [SKAction fadeInWithDuration:.25];
                SKAction *seq = [SKAction sequence:@[dis,app]];
                SKAction *blinkandrej = [SKAction repeatAction:seq count:3];
                [liveSquid runAction:blinkandrej];
                
                liveSquid.physicsBody.categoryBitMask = 0;
                
                SKNode *node1 = [self childNodeWithName:@"life1"];
                SKNode *node2 = [self childNodeWithName:@"life2"];
                SKNode *node3 = [self childNodeWithName:@"life3"];
                if ([GameData sharedGameData].lives == 2)
                {
                    [node3 removeFromParent];
                }
                if ([GameData sharedGameData].lives == 1)
                {
                    [node2 removeFromParent];
                }
                if ([GameData sharedGameData].lives == 0)
                {
                    [node1 removeFromParent];
                }
                
                
            }

        }
        
        [self processContactsForUpdate:currentTime];
        //physics
        // Handle time delta.
        // If we drop below 60fps, we still want everything to move the same distance.
        CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
        CFTimeInterval timeSinceCoin = currentTime - self.lastCoinUpdateTimeInterval;
        CFTimeInterval timeSinceLast2 = currentTime - self.lastUpdateTimeInterval2;
        CFTimeInterval timeSinceLast3 = currentTime - self.lastUpdateTimeInterval3;
        CFTimeInterval timeSinceDie = currentTime - self.lastUpdateTimeIntervalDie;
        
        self.lastUpdateTimeInterval = currentTime;
        self.lastCoinUpdateTimeInterval = currentTime;
        self.lastUpdateTimeInterval2 = currentTime;
        self.lastUpdateTimeInterval3 = currentTime;
        if (self.inv_life)
        {
            self.lastUpdateTimeIntervalDie = currentTime;
            self.inv_life = false;
        }
        self.lastUpdateTimeIntervalDie = currentTime;
        
        if (timeSinceLast > 1.0) { // more than a second since last update
            timeSinceLast = 1.0 / 60.0;
            self.lastUpdateTimeInterval = currentTime;
        }
        if (timeSinceLast2 > 1.0) {
            timeSinceLast2 = 1.0/60.0;
            self.lastUpdateTimeInterval2 = currentTime;
        }
        
        if (timeSinceLast3 > 1.0)
        {
            timeSinceLast3 = 1.0/60.0;
            self.lastUpdateTimeInterval3 = currentTime;
        }
        if (timeSinceCoin > 1.0)
        {
            timeSinceCoin = 1.0 / 60.0;
            self.lastCoinUpdateTimeInterval = currentTime;
        }
        if (timeSinceDie > 1.0 && self.inv_life)
        {
            timeSinceDie = 1.0/60.0;
            self.lastUpdateTimeIntervalDie = currentTime;
        }
        
        
    
        if (self.didcollide == false)
        {
            [self updateWithTimeSinceLastUpdate:timeSinceLast];
            if ([GameData sharedGameData].score > 15)
            {
                [self updateWithTimeSinceLastPlane2:timeSinceLast2];
            }
            [self updateWithTimeSinceLastCoin:timeSinceCoin];
            if ([GameData sharedGameData].score > 45)
            {
                [self updateWithTimeSinceLastPlane3:timeSinceLast3];
            }
                [self updateWithTimeSinceDeath:timeSinceDie];
            

        }
    
        [self enumerateChildNodesWithName:@"plane" usingBlock:^(SKNode *node, BOOL *stop){
        
            if (self.didcollide == true)
            {
                node.physicsBody.velocity = CGVectorMake(0, 0);
                
            }
            else
            {
                    node.physicsBody.velocity = CGVectorMake(-225, 0);
            }
            if (node.position.x < -15){
                [node removeFromParent];
                [GameData sharedGameData].score+=1;
                SKLabelNode *scoreLabel =(SKLabelNode *)[self childNodeWithName:@"scoreNode"];
                scoreLabel.text = [NSString stringWithFormat:@"Score: %li",[GameData sharedGameData].score];
            }
        }];
        
        [self enumerateChildNodesWithName:@"plane2" usingBlock:^(SKNode *node, BOOL *stop){
            
            if (self.didcollide == true)
            {
                node.physicsBody.velocity = CGVectorMake(0, 0);
                
            }
            else
            {
                node.physicsBody.velocity = CGVectorMake(-325, 0);
            }
            if (node.position.x < -15){
                [node removeFromParent];
                [GameData sharedGameData].score+=1;
                SKLabelNode *scoreLabel =(SKLabelNode *)[self childNodeWithName:@"scoreNode"];
                scoreLabel.text = [NSString stringWithFormat:@"Score: %li",[GameData sharedGameData].score];
            }
        }];
        
        [self enumerateChildNodesWithName:@"plane3" usingBlock:^(SKNode *node, BOOL *stop){
            
            if (self.didcollide == true)
            {
                node.physicsBody.velocity = CGVectorMake(0, 0);
                
            }
            else
            {
                node.physicsBody.velocity = CGVectorMake(-200, 0);
            }
            if (node.position.x < -15){
                [node removeFromParent];
                [GameData sharedGameData].score+=1;
                SKLabelNode *scoreLabel =(SKLabelNode *)[self childNodeWithName:@"scoreNode"];
                scoreLabel.text = [NSString stringWithFormat:@"Score: %li",[GameData sharedGameData].score];
            }
        }];
        
        [self enumerateChildNodesWithName:@"coin" usingBlock:^(SKNode *node, BOOL *stop){
            if (self.didcollide == true)
            {
                node.physicsBody.velocity = CGVectorMake(0,0);
            }
            else
            {
                if (self.didcoincollide == true)
                {
                    self.didcoincollide = false;
                
                }
                else
                {
                    node.physicsBody.velocity = CGVectorMake(-225, 0);
                }
                if (node.position.x < -15){
                [node removeFromParent];
                }
            }
        }];
    }
    
    else
    {
        SKNode *bird = (SKSpriteNode *)[self childNodeWithName:@"bird"];
        bird.physicsBody.affectedByGravity = NO;
    }
    SKNode *back1 = (SKSpriteNode *)[self childNodeWithName:@"lvl1bg1"];
    SKNode *back2 = (SKSpriteNode *)[self childNodeWithName:@"lvl2bg2"];
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

#pragma mark physicsHelpers
-(void)didBeginContact:(SKPhysicsContact *)contact {
    [self.contactQueue addObject:contact];
}

-(void)handleContact:(SKPhysicsContact*)contact {
    //1
    // Ensure you haven't already handled this contact and removed its nodes
    if (!contact.bodyA.node.parent || !contact.bodyB.node.parent) return;
    uint32_t collison = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    if (collison == (birdCategory | planeCategory) || collison == (birdCategory | plane2Category) || collison == (birdCategory | plane3Category))
    {
        if (contact.bodyB.categoryBitMask == birdCategory)
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([[defaults objectForKey:@"soundToggle"] isEqual:@"ON"]) {
                [self runAction:[SKAction playSoundFileNamed:@"lifelost.mp3" waitForCompletion:NO]];
            }

            if ([GameData sharedGameData].lives == 0)
            {
            self.didcollide = true;
            SKSpriteNode *bird =(SKSpriteNode *)[self childNodeWithName:@"bird"];
            bird.physicsBody.dynamic = NO;
            bird.physicsBody.affectedByGravity = NO;
            SKAction *hit = [SKAction moveToY:-20 duration:.7];
            SKAction *oop = [SKAction rotateByAngle:720 duration:2];
            SKAction *pause = [SKAction removeFromParent];
            SKAction *hitseq = [SKAction sequence:@[hit,pause]];
            [contact.bodyB.node runAction:oop];
            [contact.bodyB.node runAction:hitseq];
            self.gameEnding = NO;
            [self endGame];
            }
            else{
                [GameData sharedGameData].lives -=1;
                
                [contact.bodyA.node removeFromParent];
                SKNode *liveSquid = [self childNodeWithName:@"bird"];
                SKAction *dis = [SKAction fadeOutWithDuration:.25];
                SKAction *app = [SKAction fadeInWithDuration:.25];
                SKAction *seq = [SKAction sequence:@[dis,app]];
                                 SKAction *blinkandrej = [SKAction repeatAction:seq count:3];
                [liveSquid runAction:blinkandrej];
                
                liveSquid.physicsBody.categoryBitMask = 0;
                
                SKNode *node1 = [self childNodeWithName:@"life1"];
                SKNode *node2 = [self childNodeWithName:@"life2"];
                SKNode *node3 = [self childNodeWithName:@"life3"];
                if ([GameData sharedGameData].lives == 2)
                {
                    [node3 removeFromParent];
                }
                if ([GameData sharedGameData].lives == 1)
                {
                    [node2 removeFromParent];
                }
                if ([GameData sharedGameData].lives == 0)
                {
                    [node1 removeFromParent];
                }
                
                
            }
        }
    }
    else if (collison == (birdCategory | coinCategory))
    {
        if (contact.bodyB.categoryBitMask == coinCategory && self.didcoincollide == false)
        {
            self.didcoincollide = true;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([[defaults objectForKey:@"soundToggle"] isEqual:@"ON"]) {
                [self runAction:[SKAction playSoundFileNamed:@"coincollect.mp3" waitForCompletion:NO]];
            }
            
            [contact.bodyB.node removeFromParent];
            [GameData sharedGameData].levelCoins += 1;
            [GameData sharedGameData].coins += 1;
            SKLabelNode *coinLabel = (SKLabelNode *)[self childNodeWithName:@"coinNode"];
            coinLabel.text = [NSString stringWithFormat:@"Coins: %li",[GameData sharedGameData].levelCoins];
        }
    }
    
}

-(void)processContactsForUpdate:(NSTimeInterval)currentTime {
    for (SKPhysicsContact* contact in [self.contactQueue copy]) {
        [self handleContact:contact];
        [self.contactQueue removeObject:contact];
    }
}
    

@end
