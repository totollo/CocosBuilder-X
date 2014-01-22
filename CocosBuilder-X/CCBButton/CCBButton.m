//
//  CCBButton.m
//  CocosBuilder
//
//  Created by Higgx on 12/9/13.
//
//

#import "CCBButton.h"

@implementation CCBButton

-(id)init{
    if (self = [super init]) {
//        self.contentSize = CGSizeMake(120,40);
    }
    return self;
}

-(void)setAni:(CCNode *)ani{
    if (ani==nil) {
        return;
    }
    [self removeAllChildrenWithCleanup:YES];
//    [ani setPosition:ccp(self.preferedSize.width/2, self.preferedSize.height/2)];
//    [ani setPosition:ccp(100, 100)];
    [self addChild:ani];
}

@end
