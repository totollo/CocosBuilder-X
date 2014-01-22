//
//  CCBClippingNode.m
//  CocosBuilder
//
//  Created by Higgx on 12/14/13.
//
//

#import "CCBClippingNode.h"

@implementation CCBClippingNode

-(void)setMask:(CCSpriteFrame *)mask{
    self.stencil = [CCSprite spriteWithSpriteFrame:mask];
}

-(void)visit{
    
    CCNode* hock = [self getChildByTag:self.htag];
    if (hock==nil) {
        _stencil.position = CGPointMake(0, 0);
        _stencil.scaleX = 1;
        _stencil.scaleY = 1;
        _stencil.rotationX = 0;
        _stencil.rotationY = 0;
        _stencil.skewX = 0;
        _stencil.skewY = 0;
        _stencil.anchorPoint = CGPointMake(0.5, 0.5);
    }else{
        _stencil.position = hock.position;
        _stencil.scaleX = hock.scaleX;
        _stencil.scaleY = hock.scaleY;
        _stencil.rotationX = hock.rotationX;
        _stencil.rotationY = hock.rotationY;
        _stencil.skewX = hock.skewX;
        _stencil.skewY = hock.skewY;
        _stencil.anchorPoint = hock.anchorPoint;
    }
    
    [super visit];
}


@end
