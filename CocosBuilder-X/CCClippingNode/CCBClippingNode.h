//
//  CCBClippingNode.h
//  CocosBuilder
//
//  Created by Higgx on 12/14/13.
//
//

#import "CCClippingNode.h"
#import "CCSprite.h"

@interface CCBClippingNode : CCClippingNode

@property (nonatomic,retain) CCSpriteFrame* mask;
@property (nonatomic,assign) int htag;

@end
