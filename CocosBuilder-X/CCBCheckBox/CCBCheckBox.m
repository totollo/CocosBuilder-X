//
//  CCBCheckBox.m
//  CocosBuilder
//
//  Created by Higgx on 12/30/13.
//
//

#import "CCBCheckBox.h"

@implementation CCBCheckBox

-(void) setSf_check:(CCSpriteFrame *)sf_check{
    if (self.img_check != nil) {
        [self.img_check removeFromParentAndCleanup:YES];
    }
    self.img_check = [CCSprite spriteWithSpriteFrame:sf_check];
    self.img_check.anchorPoint=ccp(0, 0);
    [self addChild:self.img_check];
}

@end
