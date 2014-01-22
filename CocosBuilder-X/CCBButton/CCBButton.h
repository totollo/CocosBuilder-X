//
//  CCBButton.h
//  CocosBuilder
//
//  Created by Higgx on 12/9/13.
//
//

#import "CCControlButton.h"

@interface CCBButton : CCControlButton{
    
}

@property (nonatomic,retain) CCNode* ani;
@property (nonatomic,retain) NSString* s_normal;
@property (nonatomic,retain) NSString* s_normal_dark;
@property (nonatomic,retain) NSString* s_down;
@property (nonatomic,retain) NSString* s_disable;

@end
